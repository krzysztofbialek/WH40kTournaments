class Play::ResultsController < ApplicationController
  before_filter :load_tournament
  respond_to :json

  def index
    players = @tournament.tournament_registrations.order('current_points DESC')
    respond_with players 
  end

end
