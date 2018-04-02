class ZomatoAPIManager
  BASE_URL = '/api/v2.1'.freeze
  NY_CITY_ID = 280

  def initialize
    @headers = { 'user-key' => ::Rails.application.config.zomato_api_key,
                 'Accept' => 'application/json'}
    @conn = Faraday.new(url: 'https://developers.zomato.com', headers: @headers)
  end

  def get_cuisines
    res = zamato_api_call(endpoint: 'cuisines', params: { city_id: NY_CITY_ID })
    return unless res

    icons = ('a'..'z').to_a + ('0'..'9').to_a
    res['cuisines'].each do |c|
      cuisine = Cuisine.find_or_initialize_by(id: c['cuisine']['cuisine_id'])
      cuisine.name = c['cuisine']['cuisine_name']
      cuisine.icon ||= icons.sample
      cuisine.save!
    end
  end

  def get_restaurants(lat: 40.732013, lon: -73.996155, radius: 4000, start: 0, count: 1000)
    p "start: #{start}"
    res = zamato_api_call(endpoint: 'search',
                          params: { lat: lat,
                                    lon: lon,
                                    radius: radius,
                                    start: start,
                                    count: count })
    p res['results_shown']
    return if !res || res['results_shown'].zero?
    p 'here'
    cuisines = Cuisine.all.each_with_object({}) { |c, h| h[c.name] = c.id }

    res['restaurants'].each do |r|
      rest = Restaurant.find_or_initialize_by(id: r['restaurant']['id'])
      rest.name = r['restaurant']['name']
      rest.address = r['restaurant']['location']['address']
      rest.latitude = r['restaurant']['location']['latitude']
      rest.longitude = r['restaurant']['location']['longitude']
      rest.max_delivery_time_minutes = 0
      rest.accepts_10bis = [true, false].sample
      cuisine = r['restaurant']['cuisines'].split(", ")[0]
      rest.cuisine_id = cuisines[cuisine] if cuisines[cuisine]

      rest.save
    end
    get_restaurants(start: start + res['results_shown'])
  end

  def zamato_api_call(endpoint:, params: {})
    res = @conn.get "#{BASE_URL}/#{endpoint}", params
    res.success? ? JSON.parse(res.body) : {}
  end

end