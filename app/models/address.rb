class Address < ApplicationRecord
  validates :query, presence: true

  def save
    existing_address = Address.where address: self.address
    self.new_address = false if existing_address.present?
    super
  end

end
