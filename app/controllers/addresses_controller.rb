class AddressesController < ApplicationController
  rescue_from GoogleClientZeroResults, with: :record_not_found

  def index
    @addresses = Address.where(new_address: true).where(zero_results: false)
  end

  def create
    @query = params[:query]
    @address = Address.find_by query: @query

    if @address.nil?
      coordinates = GoogleClient.new(sanitize_form_input(@query))
      @new_address = true
      @address = Address.new(query: @query, longitude: coordinates.longitude, latitude: coordinates.latitude, address: coordinates.formatted_address)
      @address.save
    end

    respond_to do |format|
      format.html { redirect_to :root }
      format.js { render template: "addresses/error_no_results.js.erb" } if @address.zero_results
      format.js
    end
  end

  def record_not_found
    @address = Address.create(query: @query, zero_results: true)
    render template: 'addresses/error_no_results', content_type: 'text/javascript'
  end

private

  def address_params
    params.permit(:query, :latitude, :longitude, :address, :zero_results)
  end

  def sanitize_form_input(input)
    input.split(' ').join('+')
  end
end
