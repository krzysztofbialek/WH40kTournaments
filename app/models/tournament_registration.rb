class TournamentRegistration < ActiveRecord::Base

  belongs_to :tournament
  belongs_to :player
  has_many :pairings, :class_name => 'TournamentPairing', :finder_sql => Proc.new {
    %Q{
      SELECT DISTINCT *
      FROM tournament_pairings AS tp
      WHERE tp.player1_id = #{player.id} OR tp.player2_id = #{player.id}
    }
  }

  validates_uniqueness_of :player_id, :scope => :tournament_id
  validates_uniqueness_of :player_email, :scope => :tournament_id, :allow_blank => true

  after_create :notify_player, :unless => Proc.new{ self.player_email.blank? }


  def notify_player
    RegistrationsMailer.tournament_signup_confirmation(self).deliver
  end

  def as_json(*args)
    super(:only => [:army, :id, :current_points, :played_games, :extra_points, :penalty_points]).merge(:player_name => player.name, :player_full_name => player.full_name)
  end

  def current_points
    player.points_for_tournament(tournament)
  end


end
