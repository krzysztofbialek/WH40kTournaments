module TournamentsHelper
  
  def rank_points(tournament, result)
    registrations = tournament.tournament_registrations.sort{|a,b| b.final_points <=> a.final_points}
    base = (registrations.size < 15 && tournament.is_lokal?) ? 5 + registrations.size : tournament.rank_points
    place = registrations.index(result) + 1
    rank = Tournament::RankPoints[tournament.rank]
    extra_points = place <= rank ? rank + 1 - place : 0
  
    points = (base.to_f * (registrations.size + 1 - place) / registrations.size).ceil + extra_points
  end

end
