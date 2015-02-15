class ItinerariesController < ApplicationController

  def search
    pattern = {datetime: true, from: true, to: true, datetime_represents: false}

    if safe_params = valid_params(pattern, params)
      response = RestClient.get "http://api.navitia.io/v1/journeys?from=#{safe_params[:from]}&to=#{safe_params[:to]}&datetime=#{safe_params[:datetime]}&datetime_represents=#{safe_params[:datetime_represents] || 'departure'}&forbidden_uris[]=physical_mode:RapidTransit&forbidden_uris[]=physical_mode:Metro&forbidden_uris[]=physical_mode:CheckOut&forbidden_uris[]=physical_mode:CheckIn&forbidden_uris[]=physical_mode:default_physical_mode", content_type: :json, accept: :json, :'Authorization' => ENV['NAVITIA_KEY']
      itinerary = JSON.parse(response)
      if !itinerary['journeys'].nil?
        itinerary['journeys'].keep_if do |j|
          j['sections'].none? do |s|
            if s['type'] == 'public_transport'
              station_from = Station.where(code: s['from']['id']).first
              station_to = Station.where(code: s['to']['id']).first
              true if check_accessibility(station_from) == false or check_accessibility(station_to) == false
            end
          end
        end
      end
    end
    if itinerary['journeys'].nil? or itinerary['journeys'].empty?
      render json: {error: 'No itinerary found.'}, status: 200, method: :get
    else
      render json: itinerary, status: 200, method: :get
    end
  end

  private

  def check_accessibility station
    ret = (station and station.accessible)
    return ret
  end

end
