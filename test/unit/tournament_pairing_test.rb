require 'test_helper'

class TournamentPairingTest < ActiveSupport::TestCase
  
  should 'create new pairing for tournament' do
    tournament = FactoryGirl.create(:tournament)
    pairing = FactoryGirl.create(:pairing, :tournament => tournament)
    assert_equal 1, tournament.pairings.size
  end

  should 'validate points on update' do
    pairing = FactoryGirl.create(:pairing)
    assert !pairing.valid?
    pairing.update_attributes(:player1_game_points => 3, :player2_game_points => 8)
    assert pairing.valid?
  end

  should 'count match points correctly' do
    pairing = FactoryGirl.create(:pairing)
    pairing.update_attributes(:player1_game_points => 3, :player2_game_points => 8)
    assert_equal 5, pairing.player1_match_points 
    assert_equal 15, pairing.player2_match_points 
  end

end
