require 'rails_helper'

RSpec.describe AddressesController, type: :controller do
  describe "#index" do
    it "returns a 200 response" do
      get :index
      expect(response).to have_http_status "200"
    end

    it "renders index template" do
      get :index
      expect(response).to render_template("addresses/index")
    end
  end

  describe "#create" do
    before(:all) do
      @query = "123 Sesame Street"
    end

    it "creates a new record for unique queries" do
      expect {
      post :create, params: { query: @query }
      }.to change(Address.all, :count).by(1)
    end

    it "Does not create a new record for repeat queries" do
      Address.create(query: @query)
      expect {
        post :create, params: { query: @query }
      }.to change(Address.all, :count).by(0)
    end

    it "redirects to index on html request" do
      post :create, params: { query: @query }
      expect(response).to redirect_to(action: "index")
    end

    it "renders create template on successful ajax request" do
      xhr :post, :create, params: { query: @query }
      expect(response).to render_template("addresses/create")
    end

    it "renders error template on failed ajax request" do
      xhr :post, :create, params: { query: "123 nowheresville" }
      expect(response).to render_template("addresses/error_no_results")
    end
  end
end