require 'rails_helper'

RSpec.describe ItinerariesController, type: :controller do
  describe "GET #search" do
    it "should returns a json with an HTTP 200 status code with valid locations" do
      # Testing from Cergy (France) to Neuville (France)
      get :search, {  :from =>"2.325271;48.876683",
                            :to => "2.334361;48.865825",
                            :datetime => DateTime.now}

      expect(response.body).to have_json_path("journeys")
      expect(response).to have_http_status(200)
    end
  end

    it "should return a json with an error when locations are non accessible" do
      # Testing from Villepreux (France) to Rennemoulin (France)
      get :search, {  :from =>"2.0126436;48.8306355",
                            :to => "2.0421175;48.8338751",
                            :datetime => DateTime.now }

      expect(response.body).to have_json_path("error")
      expect(response).to have_http_status(200)
    end

    it "should return a  journey with the good arrival datetime" do
      get :search, { :from =>"2.325271;48.876683",
                            :to => "2.334361;48.865825",
                            :datetime => DateTime.now + 1.hours,
                            :datetime_represents => "arrival"}

      expect(response.body).to have_json_path("journeys")
      expect(response).to have_http_status(200)
    end

    it "should return a  journey with the good departure datetime" do
      get :search, { :from =>"2.325271;48.876683",
                            :to => "2.334361;48.865825",
                            :datetime => DateTime.now,
                            :datetime_represents => "departure"}

      expect(response.body).to have_json_path("journeys")
      expect(response).to have_http_status(200)
    end
end
