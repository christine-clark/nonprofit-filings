class ReceiversController < ApplicationController
  def index
    render json: { data: receivers, total_count: total_count, total_pages: total_pages }, include: [:awards], adapter: :json
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
      @receivers = @receivers.public_send("filter_by_#{key}", value) if value.present?
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
end
