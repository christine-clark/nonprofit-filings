require 'rails_helper'

RSpec.describe Parsers::XmlTaxFiling do
  describe '#generate' do
    let!(:parser) { Nokogiri::XML::SAX::Parser.new(described_class.new) }
    let!(:filename) { 'sample.xml' }
    let!(:raw_file) { fixture_file_upload(filename) }

    context 'defaults' do
      let(:tax_filing_data) { parser.parse(raw_file) }

      before(:each) { parser.parse(raw_file) }

      it 'creates filers' do
        # Count currently will fail with seeded data, need to fix this
        expect(Filer.count).to eq(1)

        first_filer = Filer.first
        expect(first_filer.ein).to eq(200253310)
        expect(first_filer.name).to eq('Pasadena Community Foundation')
        expect(first_filer.address).to eq('301 E Colorado Blvd No 810')
        expect(first_filer.city).to eq('Pasadena')
        expect(first_filer.state).to eq('CA')
        expect(first_filer.postal_code).to eq('91101')
      end

      it 'creates receivers' do
        # There is a duplicate receiver out of 3, so only should be 2 total
        # Count currently will fail with seeded data, need to fix this
        expect(Receiver.count).to eq(2)

        first_receiver = Receiver.all[0]
        expect(first_receiver.ein).to eq(131624102)
        expect(first_receiver.name).to eq('National Audubon Society')
        expect(first_receiver.address).to eq('225 Varick Street 7th Floor')
        expect(first_receiver.city).to eq('New York')
        expect(first_receiver.state).to eq('NY')
        expect(first_receiver.postal_code).to eq('10014')

        second_receiver = Receiver.all[1]
        expect(second_receiver.ein).to eq(954765734)
        expect(second_receiver.name).to eq('Southern California Public Radio - KPCC')
        expect(second_receiver.address).to eq('474 S Raymond Ave')
        expect(second_receiver.city).to eq('Pasadena')
        expect(second_receiver.state).to eq('CA')
        expect(second_receiver.postal_code).to eq('91105')

        third_receiver = Receiver.all[2]
        expect(third_receiver).to be_nil
      end

      it 'creates awards' do
        # Count currently will fail with seeded data, need to fix this
        expect(Award.count).to eq(3)

        first_award = Award.all[0]
        first_receiver = Receiver.all[0]
        expect(first_award.receiver_id).to eq(first_receiver.id)
        expect(first_award.grant_cash_amount).to eq(864100)
        expect(first_award.grant_purpose).to eq('General Support')

        second_award = Award.all[1]
        second_receiver = Receiver.all[1]
        expect(second_award.receiver_id).to eq(second_receiver.id)
        expect(second_award.grant_cash_amount).to eq(14665)
        expect(second_award.grant_purpose).to eq('General Support')

        third_award = Award.all[2]
        expect(third_award.receiver_id).to eq(second_receiver.id)
        expect(third_award.grant_cash_amount).to eq(50000)
        expect(third_award.grant_purpose).to eq('Annual Support')
      end
    end    
  end
end
