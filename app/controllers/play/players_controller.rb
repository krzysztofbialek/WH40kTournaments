class Play::PlayersController < ApplicationController
  before_filter :load_tournament
  respond_to :json

  def index
    players = @tournament.tournament_registrations
    respond_with players 
  end

end
