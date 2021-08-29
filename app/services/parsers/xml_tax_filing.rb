module Parsers
  # Stream and parse xml files by creating a subclass of Nokogiri::XML::SAX::Document
  class XmlTaxFiling < Nokogiri::XML::SAX::Document
    INSERT_BATCH_SIZE = 5000.freeze
  
    def start_document
      @filers = []
      @receivers = []
      @awards = []
      @errors = []
    end
  
    def start_element(name, attrs = [])
      @element = name
      @attrs = attrs.to_h
      
      if name == 'ReturnHeader'
        @inside_return_header = true
      elsif name == 'ReturnData'
        @inside_return_data = true
      elsif name == 'Filer'
        @inside_filer = true
        @filer = { ein: nil, name: nil, address: nil, city: nil, state: nil, postal_code: nil }
      elsif name == 'IRS990ScheduleI'
        @inside_tax_filing = true
      elsif name == 'RecipientTable'
        @inside_receiver = true
        @receiver = { ein: nil, name: nil, address: nil, city: nil, state: nil, postal_code: nil }
      elsif name == 'CashGrantAmt'
        @award = { grant_cash_amount: nil, grant_purpose: nil, receiver_ein: nil, receiver_id: nil }
      end
    end

    def characters(string)
      set_filer_info(string) if @inside_filer
      set_receiver_info(string) if @inside_receiver
      set_award_info(string) if @inside_return_data
    end
  
    def end_element(name)
      if name == 'ReturnHeader'
        @inside_return_header = false
      elsif name == 'ReturnData'
        @inside_return_data = false
      elsif name == 'Filer'
        if @filer.is_a?(Hash)
          @filer[:created_at] = DateTime.now
          @filer[:updated_at] = DateTime.now
          @filers.push(@filer)
        end
        @filer = nil
        @inside_filer = false
      elsif name == 'RecipientTable'
        if @receiver.is_a?(Hash)
          @receiver[:created_at] = DateTime.now
          @receiver[:updated_at] = DateTime.now
          @receivers.push(@receiver)
        end
        @receiver = nil
        @inside_receiver = false
      elsif name == 'PurposeOfGrantTxt'
        if @award.is_a?(Hash)
          # Save receiver_ein temporarily which will be used to set receiver_id later.
          @award[:receiver_ein] = @receiver[:ein]
          @awards.push(@award)
        end
        @award = nil
      elsif name == 'IRS990ScheduleI'
        @inside_tax_filing = false
      end
    end
  
    def end_document
      batch_insert_items
    end

    private

    def batch_insert_items
      # TODO: Implement error handling to track failures
      insert_in_batches('Filer', @filers)
      insert_in_batches('Receiver', @receivers)
      insert_in_batches('Award', @awards)
    end

    def set_filer_info(value)
      return unless @filer.is_a?(Hash)

      if @element.include?('EIN') && !value.match(/^\n/)
        @filer[:ein] = value
      elsif @element.include?('NameLine') && !value.match(/^\n/)
        @filer[:name] = value
      elsif @element.include?('AddressLine') && !value.match(/^\n/)
        @filer[:address] = value
      elsif @element.include?('City') && !value.match(/^\n/)
        @filer[:city] = value
      elsif @element.include?('State') && !value.match(/^\n/)
        @filer[:state] = value
      elsif @element.include?('ZIP') && !value.match(/^\n/) 
        @filer[:postal_code] = value
      end
    end

    def set_receiver_info(value)
      return unless @receiver.is_a?(Hash)

      if @element.include?('EIN') && !value.match(/^\n/) 
        @receiver[:ein] = value
      elsif @element.include?('NameLine') && !value.match(/^\n/) 
        @receiver[:name] = value
      elsif @element.include?('AddressLine') && !value.match(/^\n/) 
        @receiver[:address] = value
      elsif @element.include?('City') && !value.match(/^\n/) 
        @receiver[:city] = value
      elsif @element.include?('State') && !value.match(/^\n/) 
        @receiver[:state] = value
      elsif @element.include?('ZIP') && !value.match(/^\n/) 
        @receiver[:postal_code] = value
      end
    end

    def set_award_info(value)
      return unless @award.is_a?(Hash)

      if @element == 'CashGrantAmt' && !value.match(/^\n/) 
        @award[:grant_cash_amount] = value
      elsif @element == 'PurposeOfGrantTxt' && !value.match(/^\n/) 
        @award[:grant_purpose] = value
      end
    end

    def insert_in_batches(resource_class, resource_array)
      return unless resource_array.size.positive?

      # Awards have to have receivers so they must be saved last and
      # receivers must be set on each award after receivers are saved.
      set_receivers_on_awards(resource_array) if resource_class === 'Award'

      klass = resource_class.constantize
      resource_array.in_groups_of(INSERT_BATCH_SIZE, false) do |batch_array|
        klass.insert_all(batch_array)
      end
    end

    def set_receivers_on_awards(awards)
      awards.each do |award|
        found_receiver = Receiver.find_by(ein: award[:receiver_ein])
        award.delete(:receiver_ein) # no longer needed
        award[:receiver_id] = found_receiver&.id
        award[:created_at] = DateTime.now
        award[:updated_at] = DateTime.now
      end
    end
  end
end
