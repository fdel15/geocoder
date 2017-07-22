class AddressesController < ApplicationController
  def index
    @addresses = Address.where(new_address: true).where(zero_results: false)
  end

  def create
    @query = sanitize_form_input(params[:query])
    @address = Address.find_by query: @query

    if @address.nil?
      coordinates = GoogleClient.new(@query)
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


private

  def address_params
    params.permit(:query, :latitude, :longitude, :address, :zero_results)
  end

  def sanitize_form_input(input)
    input.split(' ').join('+')
  end
end
