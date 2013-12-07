class TeamRegistrationSerializer < ActiveModel::Serializer
  attributes :id, :current_points, :current_victory_points, :played_games, :extra_points, :penalty_points, :player_name, :player_full_name

  def player_name
    object.name
  end

  def player_full_name
    object.name
  end

end
