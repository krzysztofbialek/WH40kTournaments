class TeamRegistrationPlayer < ActiveRecord::Base
  attr_accessible :player_id, :team_registration_id, :army


  validates_presence_of :player_id

  belongs_to :player
  belongs_to :team_registration

end
