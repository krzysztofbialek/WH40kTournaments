class TournamentSerializer < ActiveModel::Serializer
  root false

  attributes :id, :current_round, :name, :rank, :state

end
