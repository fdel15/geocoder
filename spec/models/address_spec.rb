require 'rails_helper'

RSpec.describe Address, type: :model do
  it "is valid with a query" do
    address = Address.new(query: "123 Sesame Street")
    expect(address).to be_valid
  end

  it "is invalid without a query" do
    address = Address.new(query: nil)
    address.valid?
    expect(address.errors[:query]).to include("can't be blank")
  end

  describe "save method sets new_address value" do
    before(:each) do
      @address = Address.new(query: "123 Sesame Street", address: "123 Sesame Street")
    end

    context "when the address is unique" do
      it "defaults to true" do
        @address.save
        expect(@address.new_address).to eq true
      end
    end

    context "when the address already exists in the database" do
      it "new_method is false after save" do
        Address.create(query: "123 Sesame Street", address: "123 Sesame Street")
        @address.save
        expect(@address.new_address).to eq false
      end
    end
  end
end
