class Play::PlayersController < ApplicationController
  before_filter :load_tournament
  respond_to :json

  def index
    players = @tournament.tournament_registrations
    respond_with players 
  end

  def destroy
    player = TournamentRegistration.find(params[:id])
    if player.destroy
      respond_with :success
    end
  end

end
