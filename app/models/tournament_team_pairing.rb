class TournamentTeamPairing < ActiveRecord::Base
  attr_accessible :pausing, :round, :table, :team1_game_points, :team1_id, :team1_match_points, :team2_game_points, :team2_id, :team2_match_points, :tournament_id
  
  belongs_to :team1, :class_name => "TeamRegistration", :foreign_key => "team1_id"
  belongs_to :team2, :class_name => "TeamRegistration", :foreign_key => "team2_id"
  belongs_to :tournament

  validates_presence_of :team1_game_points, :team2_game_points, :on => :update, :unless => Proc.new {|p| p.team1_id_changed? || p.team2_id_changed?}
  validates_numericality_of :team1_game_points, :team2_game_points, :greater_than_or_equal => 0, :on => :update, :allow_blank => true

  #before_update :count_match_points
  after_save :update_registration
  after_update :finish_tournament
  
  def update_registration
    registrations = tournament.team_registrations.where(:id => [team1_id, team2_id])
    registrations.each_with_index do |reg, i|
      reg.update_attributes(:current_points => reg.points_for_tournament(tournament), :played_games => round, :current_victory_points => reg.game_points_for_tournament(tournament))
    end
  end
  
  def finish_tournament
    tournament.finish! if tournament.can_finish?
  end
end
