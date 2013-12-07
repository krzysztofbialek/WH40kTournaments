class Play::ResultsController < ApplicationController
  before_filter :load_tournament

  def index
    if @tournament.for_teams?
      @players = @tournament.team_registrations.order('current_points DESC, current_victory_points DESC')
    else
      @players = @tournament.tournament_registrations.order('current_points DESC, current_victory_points DESC')
    end
    render json: @players, root: false 
  end

end
