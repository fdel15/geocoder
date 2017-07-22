module AddressesHelper
  def display_date(date)
    date.strftime("%B %d, %Y")
  end

  def address_table
    html = DataTable.render(@addresses) do |t|
      t.column :address, "Address"
      t.column :longitude, "Longitude"
      t.column :latitude, "Latitude"
      t.column :created_at, "Date" do |row, value|
        "#{ display_date(value[:created_at]) }"
      end
    end
    html.html_safe
  end

end
