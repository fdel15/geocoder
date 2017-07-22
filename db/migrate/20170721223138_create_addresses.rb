class CreateAddresses < ActiveRecord::Migration[5.0]
  def change
    create_table :addresses do |t|
      t.string  :address
      t.string  :longitude
      t.string  :latitude
      t.string  :query
      t.boolean :new_address, default: true
      t.boolean :zero_results, default: false
      t.timestamps
    end

    add_index :addresses, :query
    add_index :addresses, :address
  end
end
