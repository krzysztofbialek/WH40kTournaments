class TournamentRegistration < ActiveRecord::Base

  belongs_to :tournament
  belongs_to :player

  validates_uniqueness_of :player_id, :scope => :tournament_id
  validates_uniqueness_of :player_email, :scope => :tournament_id

  after_create :notify_player, :if => :player_email

  def notify_player
    RegistrationsMailer.tournament_signup_confirmation(self).deliver
  end

end
