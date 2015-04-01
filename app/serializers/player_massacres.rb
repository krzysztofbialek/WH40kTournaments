class PlayerSerializer < ActiveModel::Serializer
  attributes :name, :massacres_count


  def name
    object.full_name
  end

  def massacres_count
    object.player1_pairings.where(:player1_match_points == 20).size +
    object.player2_pairings.where(:player2_match_points == 20).size
  end
end
