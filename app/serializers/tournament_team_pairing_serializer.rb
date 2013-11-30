class TournamentTeamPairingSerializer < ActiveModel::Serializer
  
  attributes :id, :team1_id, :team2_id, :team1_game_points, :team2_game_points, :team1_match_points, :team2_match_points, :round, :table, :pausing, :team1_name, :team2_name

  def team1_name
    object.team1.try(:name)
  end
  
  def team2_name
    object.team2.try(:name)
  end
end
