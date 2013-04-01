class TournamentRegistration < ActiveRecord::Base

  belongs_to :tournament
  belongs_to :player

  validates_uniqueness_of :player_id, :scope => :tournament_id
  validates_uniqueness_of :player_email, :scope => :tournament_id, :allow_blank => true

  after_create :notify_player, :unless => Proc.new{ self.player_email.blank? }


  def notify_player
    RegistrationsMailer.tournament_signup_confirmation(self).deliver
  end

  def as_json(*args)
    super(:only => [:army, :id], :methods => [:current_points, :played_games]).merge(:player_name => player.name, :player_full_name => player.full_name)
  end

  def current_points
    player.points_for_tournament(tournament)
  end

  def played_games
    tournament.pairings.where('player1_id = ? OR player2_id = ?', player_id, player_id).count
  end

end
