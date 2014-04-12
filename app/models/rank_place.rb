class RankPlace < ActiveRecord::Base
  attr_accessible :challengers_count, :leagues_count, :locals_count, :masters_count, :place, :player_id, :total_points

  belongs_to :player
  has_many :played_tournaments, through: :player
  has_many :player1_pairings, through: :player
  has_many :player2_pairings, through: :player

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

  def self.update_places
    places = RankPlace.all.sort_by(&:total_points).reverse
    places.each{|p| p.update_place(places)}
  end

  def update_place(places)
    self.update_column(:place, places.index(self) + 1)
  end

  def current_place
    RankPlace.all.sort_by(&:total_points).reverse.index(self) + 1
  end
end


