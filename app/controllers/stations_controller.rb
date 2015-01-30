class StationsController < ApplicationController

  def get
    Station.delete_all
    stations = Array.new
    14.times do |p|
      raw_response = RestClient.get 'http://api.navitia.io/v1/coverage/fr-idf/commercial_modes/commercial_mode:bus/lines?start_page=' + p.to_s, content_type: :json, accept: :json, :'Authorization' => ENV['NAVITIA_KEY']
      json_response = JSON.parse(raw_response)
      json_response['lines'].each do |l|
        l['routes'].each do |d|
          raw_response = RestClient.get 'http://api.navitia.io/v1/coverage/fr-idf/routes/' + d['id'] + '?depth=3', content_type: :json, accept: :json, :'Authorization' => ENV['NAVITIA_KEY']
          json_response = JSON.parse(raw_response)
          json_response['routes'].each do |r|
            r['stop_points'].each do |s|
              stations << s['id'] unless stations.include? s['id']
            end
          end
        end
      end
    end
    stations.each do |s|
      Station.create(code: s, accessible: true)
    end
    render nothing: true
  end

end
