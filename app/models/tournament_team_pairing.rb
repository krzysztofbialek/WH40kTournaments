class TournamentTeamPairing < ActiveRecord::Base
  attr_accessible :pausing, :round, :table, :team1_game_points, :team1_id, :team1_match_points, :team2_game_points, :team2_id, :team2_match_points, :tournament_id
  
  belongs_to :team1, :class_name => "TeamRegistration", :foreign_key => "team1_id"
  belongs_to :team2, :class_name => "TeamRegistration", :foreign_key => "team2_id"


  validates_presence_of :team1_game_points, :team2_game_points, :on => :update, :unless => Proc.new {|p| p.team1_id_changed? || p.team2_id_changed?}
  validates_numericality_of :team1_game_points, :team2_game_points, :greater_thani_or_equal => 0, :on => :update, :allow_blank => true

  #before_update :count_match_points
  #after_save :update_registration
  #after_update :finish_tournament
end
