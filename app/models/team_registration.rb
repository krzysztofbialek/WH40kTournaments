#encoding: utf-8
class TeamRegistration < ActiveRecord::Base
  attr_accessible :team_registration_players_attributes, :current_points, :extra_points, :current_victory_points, :deleted_at, :name, :city, :paid_at, :payment_send, :penalty_points, :played_games, :roster_send, :roster_valid, :tournament_id

  belongs_to :tournament  
  has_many :team_registration_players
  has_many :players, through: :team_registration_players
  has_many :team1_pairings, :class_name => 'TournamentTeamPairing', :foreign_key => 'team1_id'
  has_many :team2_pairings, :class_name => 'TournamentTeamPairing', :foreign_key => 'team2_id'

  accepts_nested_attributes_for :team_registration_players
  
  def played_with?(registration = nil)
    return false unless registration.present?
    tournament = registration.tournament_id
    team1_pairings.where(:tournament_id => tournament, :team2_id => registration.id).any? or
    team2_pairings.where(:tournament_id => tournament, :team1_id => registration.id).any?
  end
  
  def points_for_tournament(id)
    team1_pairings.where(:tournament_id => id).sum(:team1_match_points) +
    team2_pairings.where(:tournament_id => id).sum(:team2_match_points) 
  end
  
  def game_points_for_tournament(id)
    team1_pairings.where(:tournament_id => id).sum(:team1_game_points) +
    team2_pairings.where(:tournament_id => id).sum(:team2_game_points) 
  end
  
  def final_points
    current_points + extra_points - penalty_points
  end

  def armies
    team_registration_players.collect{|r| r.army}.join(',')
  end  
  
  def  self.to_csv(results)
    CSV.generate(:col_sep => ';') do |csv|
      csv << ['Miejsce', 'ID Ligowe', 'Imię', 'Nazwisko', 'Armia Miasto', 'Punkty', 'ID Sedziowka']
      results.each_with_index do |r, i|
        r.team_registration_players.each do |trp|
          csv << [
                  i + 1,
                  trp.player.league_id,
                  trp.player.first_name,
                  trp.player.last_name,
                  trp.army,
                  trp.player.city,
                  trp.player.nick,
                 ] 
        end 
      end
    end 
  end
end
