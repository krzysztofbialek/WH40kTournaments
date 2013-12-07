class TournamentPairingSerializer < ActiveModel::Serializer
  
  attributes :id, :player1_id, :player2_id, :player1_game_points, :player2_game_points, :player1_match_points, :player2_match_points, :round, :table, :pausing, :player1_name, :player2_name

  def player1_name
    object.player1.try(:name)
  end
  
  def player2_name
    object.player2.try(:name)
  end
end
