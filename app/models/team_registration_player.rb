class TeamRegistrationPlayer < ActiveRecord::Base
  attr_accessible :player_id, :team_registration_id


  validate :player_id, :team_registration_id, presence: true

  belongs_to :player
  belongs_to :team_registration

end
