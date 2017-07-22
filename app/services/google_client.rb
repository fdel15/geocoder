class GoogleClient

  attr_reader :response

  def initialize(query)
    @response = JSON.parse(RestClient.get("https://maps.googleapis.com/maps/api/geocode/json?address=#{query}&key=#{GOOGLE_API_KEY}"))
    raise GoogleClientZeroResults.new("Zero results found. Please check your address and try again.") if zero_results?
  end

  def formatted_address
    response["results"].first["formatted_address"]
  end

  def longitude
    response["results"].first["geometry"]["location"]["lng"]
  end

  def latitude
    response["results"].first["geometry"]["location"]["lat"]
  end

  def zero_results?
    response["status"] == "ZERO_RESULTS"
  end
end