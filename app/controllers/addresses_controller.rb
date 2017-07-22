class AddressesController < ApplicationController
  def index
    @addresses = Address.where(new_address: true).where(zero_results: false)
  end

  def create
    render json: "Hello World"
  end
end
