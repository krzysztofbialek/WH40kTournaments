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

  def update
    player = @tournament.tournament_registrations.find(params[:id])
    if player.update_attributes(params.slice(:extra_points, :penalty_points))
      respond_with :status => 200
    else
      render :json => {:msg => pairing.errors.full_messages.join(',')}, :status => 422
    end
  end
end
