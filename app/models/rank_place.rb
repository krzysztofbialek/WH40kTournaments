class RankPlace < ActiveRecord::Base
  attr_accessible :challengers_count, :leagues_count, :locals_count, :masters_count, :place, :player_id, :total_points

  belongs_to :player

  def total_tournaments
    player.tournament_registrations.count
  end 

end


