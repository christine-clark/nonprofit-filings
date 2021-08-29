class FilersController < ApplicationController
  def index
    render json: { data: filers, total_count: total_count, total_pages: total_pages }, adapter: :json
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

  def filers
    @filers = Filer.all
    permitted_params.each do |key, value|
      @filers = @filers.public_send("filter_by_#{key}", value) if value.present?
    end
    @filers
  end

  def paged_filers
    filers.page(permitted_params[:page]).per(permitted_params[:per_page])
  end

  def total_count
    paged_filers.total_count
  end

  def total_pages
    paged_filers.total_pages
  end
end
