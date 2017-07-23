require 'rails_helper'

RSpec.feature "Addresses", type: :feature do

  scenario "result is returned for valid address", js: true do
    query = "123 Sesame Street"

    visit root_path
    fill_in "query", with: query
    click_on "submit-form"

    expect(page).to have_css "p.formatted-address"
    expect(page).to have_css "p.longitude"
    expect(page).to have_css "p.latitude"
  end

  scenario "error is returned for an invalid address", js: true do
    query = "123 nowheresville"

    visit root_path
    fill_in "query", with: query
    click_on "submit-form"

    expect(page).to have_css "p.error-message"
  end
end