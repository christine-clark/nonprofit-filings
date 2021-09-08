# Get /receivers
class ReceiversController < ApplicationController
  def index
    render json: {
      data: formatted_receivers,
      total_count: total_count,
      total_pages: total_pages
    }, include: [:awards], adapter: :json
  end

  private

  def permitted_params
    params.permit(
      :filename,
      :ein,
      :name,
      :state,
      :page,
      :per_page
    )
  end

  def receivers
    @receivers = Receiver.all
    permitted_params.each do |key, value|
      @receivers = @receivers.public_send("filter_by_#{key}", value) if value.present? && excluded_filters.exclude?(key)
    end
    @receivers
  end

  def paged_receivers
    receivers.page(permitted_params[:page]).per(permitted_params[:per_page])
  end

  def total_count
    paged_receivers.total_count
  end

  def total_pages
    paged_receivers.total_pages
  end

  def formatted_receivers
    paged_receivers.map do |receiver|
      {
        id: receiver.id,
        type: 'receivers',
        attributes: {
          ein: receiver.ein,
          name: receiver.name,
          address: receiver.address,
          city: receiver.city,
          state: receiver.state,
          postal_code: receiver.postal_code
        },
        included: formatted_awards(receiver.id, receiver.awards)
      }
    end
  end

  def formatted_awards(receiver_id, awards)
    awards.map do |award|
      {
        id: award.id,
        type: 'awards',
        attributes: {
          grant_cash_amount: award.grant_cash_amount,
          grant_purpose: award.grant_purpose
        },
        relationships: {
          receiver: {
            data: { id: receiver_id, type: 'receivers' }
          }
        }
      }
    end
  end

  def excluded_filters
    %w[page per_page]
  end
end
