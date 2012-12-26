require 'test_helper'

class TournamentTest < ActiveSupport::TestCase
  
  should 'have current round equal to 0 after create' do
    tournament = Tournament.new
    assert_equal 0, tournament.current_round
  end 

  should 'increment current round with "update_round"' do
    tournament = Tournament.new
    tournament.update_round
    assert_equal 1, tournament.current_round
  end

end
