require File.expand_path(File.dirname(__FILE__) + '/../test_helper')


class TournamentTest < ActiveSupport::TestCase
  context 'current_round' do 
  
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

  context 'pairings' do

    setup do
      @tournament = FactoryGirl.create(:tournament)
    end   
 
    should 'generate pairings with #generate_pairings' do
      10.times{FactoryGirl.create(:registration, :tournament => @tournament)}

      @tournament.generate_pairings

      assert_equal 5, @tournament.pairings.count
    end

    should 'generating pausing pairing when players number is odd' do
      3.times{FactoryGirl.create(:registration, :tournament => @tournament)}
    
      @tournament.generate_pairings

      assert_equal 2, @tournament.pairings.count
    end

    should 'mark pausing player with flag' do
      3.times{FactoryGirl.create(:registration, :tournament => @tournament)}
    
      @tournament.generate_pairings

      assert @tournament.pausing_pairing.present?
    end
    
    should 'set correct round in pairing' do
      2.times{FactoryGirl.create(:registration, :tournament => @tournament)}
    
      @tournament.generate_pairings

      assert_equal @tournament.current_round, @tournament.pairings.last.round
    end
    
    should 'increment before generating pairings' do
      2.times{FactoryGirl.create(:registration, :tournament => @tournament)}
    
      @tournament.generate_pairings

      assert_equal 1, @tournament.current_round
    end
  end
end
