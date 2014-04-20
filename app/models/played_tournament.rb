#encoding: utf-8
class PlayedTournament < ActiveRecord::Base
  attr_accessible :place, :player_id, :points, :tournament_id, :registration_id

  belongs_to :tournament
  belongs_to :player
  has_one :rank_place, through: :player
  belongs_to :tournament_registration, foreign_key: 'registration_id'
  after_create :update_rank_place

  def update_rank_place
    rp = RankPlace.find_or_initialize_by_player_id(self.player.id)
    rp.total_points = 0 unless rp.persisted?
    rp.total_points += rank_points(self.tournament, self.place)
    case tournament.rank
    when 'Lokal'
      rp.increment(:locals_count)
    when 'Czelendżer'
      rp.increment(:challengers_count)
    when 'Master'
      rp.increment(:masters_count)
    end
    rp.save
  end

  def rank_points(tournament, result)
    registrations = tournament.tournament_registrations
    base = (registrations.size < 15 && tournament.is_lokal?) ? 5 + registrations.size : tournament.rank_points
    rank = Tournament::RankPoints[tournament.rank]
    extra_points = place <= rank ? rank + 1 - place : 0

    points = (base.to_f * (registrations.size + 1 - place) / registrations.size).ceil + extra_points
  end
end
