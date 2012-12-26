class TournamentPairing < ActiveRecord::Base

  belongs_to :tournament, :dependent => :destroy

  validates_presence_of :player1_game_points, :player2_game_points, :on => :update
  validates_numericality_of :player1_game_points, :player2_game_points, :on => :update

  after_update :count_match_points


  def count_match_points
    if player1_game_points && player2_game_points
      diff = (player1_game_points - player2_game_points).abs
      points = [player1_game_points, player2_game_points]
      won = points.index(points.max) + 1
      winner_points = (diff >= 10)? 20 : (10 + diff)
      update_match_points(won, winner_points) 
    end  
  end

  def update_match_points(won, points)
    send("player#{won}_match_points=", points ) 
    send("player#{(won == 1? 2 : 1)}_match_points=", 20 - points ) 
  end

end
