class Play::PlayersController < ApplicationController
  before_filter :load_tournament
  respond_to :json

  def index
    if @tournament.for_teams
      players = @tournament.team_registrations
    else
      players = @tournament.tournament_registrations
    end
    render :json => players
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
