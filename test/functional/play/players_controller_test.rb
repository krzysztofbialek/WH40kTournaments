require 'test_helper'

class Play::PlayersControllerTest < ActionController::TestCase

  should 'respond with players in json format' do
    tournament = FactoryGirl.create(:tournament)
    player = FactoryGirl.create(:registration, :tournament => tournament)
    get :index, :tournament_id => tournament.id, :format => :json
    assert_equal tournament.tournament_registrations.to_json, response.body
  end

end
