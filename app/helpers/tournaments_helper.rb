module TournamentsHelper
  
  def rank_points(tournament, result)
    registrations = tournament.tournament_registrations.sort{|a,b| b.current_points <=> a.final_points}
    base = (registrations.size < 15 && tournament.is_lokal?) ? 5 + registrations.size : tournament.rank_points
    place = registrations.index(result) + 1
    extra_points = place <= 3 ? 4 - place : 0
  
    points = (base.to_f * (registrations.size + 1 - place) / registrations.size).ceil + extra_points
  end

end
