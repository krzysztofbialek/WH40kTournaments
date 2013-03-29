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
      2.times{FactoryGirl.create(:registration, :tournament => @tournament)}
    end   
 
    should 'generate pairings with #generate_pairings' do
      8.times{FactoryGirl.create(:registration, :tournament => @tournament)}

      @tournament.generate_pairings

      assert_equal 5, @tournament.pairings.count
    end

    should 'generating pausing pairing when players number is odd' do
      FactoryGirl.create(:registration, :tournament => @tournament)
    
      @tournament.generate_pairings

      assert_equal 2, @tournament.pairings.count
    end

    should 'mark pausing player with flag' do
      FactoryGirl.create(:registration, :tournament => @tournament)
    
      @tournament.generate_pairings

      assert @tournament.pausing_pairing.present?
    end
    
    should 'set correct round in pairing' do
    
      @tournament.generate_pairings

      assert_equal @tournament.current_round, @tournament.pairings.last.round
    end
    
    should 'increment before generating pairings' do
    
      assert_equal 0, @tournament.current_round
      
      @tournament.generate_pairings

      assert_equal 1, @tournament.current_round
    end

    should 'not generate round if reached last round' do
      3.times{@tournament.generate_pairings}
      
      assert_equal 3, @tournament.pairings.size
      assert_equal 3, @tournament.current_round
    
      assert_no_difference(["@tournament.current_round", "@tournament.pairings.size"]) do
        @tournament.generate_pairings
      end
    end

    should 'add correct table numbers to generate pairings' do
      4.times{FactoryGirl.create(:registration, :tournament => @tournament)}
      3.times{@tournament.generate_pairings}
     
      pairings = @tournament.pairings.order('tournament_pairings.table ASC')
      assert_equal 1, pairings.first.table
      assert_equal 3, pairings.last.table
    end

    context 'correct swiss system in pairings generation' do

      should 'not generate pairings with same players' do
        
        8.times{FactoryGirl.create(:registration, :tournament => @tournament)}
        player1 = @tournament.tournament_registrations[0].player
        player2 = @tournament.tournament_registrations[1].player
        @tournament.update_attribute('number_of_rounds', 5)
        4.times do |i|
          @tournament.generate_pairings
          unless i == 0 
            tp = @tournament.pairings.where(:round => i)
            tp.each do |p|
              p.update_attributes(:player1_game_points => rand(10), :player2_game_points => rand(10))
            end
          end
        end
            
        assert_equal 1, @tournament.pairings.where(:player1_id => player2.id, :player2_id => player1.id).count +  @tournament.pairings.where(:player1_id => player1.id, :player2_id => player2.id).count
      end
    
    end

  end
end
