class TournamentRegistration < ActiveRecord::Base

  belongs_to :tournament
  belongs_to :player

  validates_uniqueness_of :player_id, :scope => :tournament_id
  validates_uniqueness_of :player_email, :scope => :tournament_id, :allow_blank => true

  after_create :notify_player, :unless => Proc.new{ self.player_email.blank? }


  def notify_player
    RegistrationsMailer.tournament_signup_confirmation(self).deliver
  end

end
