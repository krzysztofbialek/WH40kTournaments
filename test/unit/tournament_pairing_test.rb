require 'test_helper'

class TournamentPairingTest < ActiveSupport::TestCase
  
  should 'create valid pairing for tournament' do
    tournament = FactoryGirl.create(:tournament)
    pairing = FactoryGirl.create(:pairing, :tournament => tournament)
    
    assert pairing.valid?
  end

end
