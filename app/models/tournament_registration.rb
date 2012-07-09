class TournamentRegistration < ActiveRecord::Base

  belongs_to :tournament
  belongs_to :player

  validates_uniqueness_of :player_id

end
