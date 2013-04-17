class TournamentPairing < ActiveRecord::Base

  belongs_to :tournament
  belongs_to :player1, :class_name => "Player", :foreign_key => "player1_id"
  belongs_to :player2, :class_name => "Player", :foreign_key => "player2_id"


  validates_presence_of :player1_game_points, :player2_game_points, :on => :update
  validates_numericality_of :player1_game_points, :player2_game_points, :on => :update

  before_update :count_match_points
  after_update :update_registration
  after_update :finish_tournament

  def update_registration
    registrations = tournament.tournament_registrations.where(:player_id => [player1_id, player2_id])
    registrations.each_with_index do |reg, i|
      reg.update_attributes(:current_points => reg.player.points_for_tournament(tournament), :played_games => round )
    end
  end

  def finish_tournament
    tournament.finish! if tournament.can_finish?
  end

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

  def as_json(*args)
    super(
      :only => [:id, :player1_id, :player2_id, :player1_game_points, :player2_game_points, :player1_match_points, :player2_match_points, :round, :table, :pausing]
    ).merge(:player1_name => player1.try(:name), :player2_name => player2.try(:name))
  end


end
