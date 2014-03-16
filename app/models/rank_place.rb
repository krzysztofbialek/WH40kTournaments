class RankPlace < ActiveRecord::Base
  attr_accessible :challengers_count, :leagues_count, :locals_count, :masters_count, :place, :player_id, :total_points

  belongs_to :player
  has_many :played_tournaments, through: :player

  def total_tournaments
    player.tournament_registrations.count
  end 

  def won_games_count
    player.player1_pairings.where('player1_match_points > 10').size +
    player.player2_pairings.where('player2_match_points > 10').size
  end

  def lost_games_count
    player.player1_pairings.where('player1_match_points < 10').size +
    player.player2_pairings.where('player2_match_points < 10').size
  end

  def tied_games_count
    player.player1_pairings.where('player1_match_points = 10').size +
    player.player2_pairings.where('player2_match_points = 10').size
  end

  def update_place

  end
end


