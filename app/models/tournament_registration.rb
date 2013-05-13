#encoding: utf-8
class TournamentRegistration < ActiveRecord::Base

  MONITORED_ATTRS = ['roster_send', 'roster_valid', 'payment_send']

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
  after_update :notify_player_of_change, :unless => Proc.new{ self.player_email.blank? }


  def notify_player
    RegistrationsMailer.tournament_signup_confirmation(self).deliver
  end

  def notify_player_of_change
    change = (self.changed & MONITORED_ATTRS).first
    if change
      if self.send(change)
        RegistrationsMailer.tournament_change_confirmation(self, change).deliver    
      end
    end
  end

  def as_json(*args)
    super(:only => [:army, :id, :current_points, :current_victory_points, :played_games, :extra_points, :penalty_points]).merge(:player_name => player.name, :player_full_name => player.full_name )
  end

  def  self.to_csv(results)
    CSV.generate(:col_sep => ';') do |csv|
      csv << ['Miejsce', 'ID Ligowe', 'Imię', 'Nazwisko', 'Armia Miasto', 'Punkty', 'ID Sedziowka']
      results.each_with_index do |registration, i|
        csv << [
                i + 1,
                registration.player.league_id,
                registration.player.first_name,
                registration.player.last_name,
                registration.army,
                registration.player.city,
                registration.player.nick,
               ] 
      end 
    end 
  end

  def victory_points
    player.game_points_for_tournament(tournament)
  end
  
  def final_points
    player.points_for_tournament(tournament) + extra_points - penalty_points
  end

end
