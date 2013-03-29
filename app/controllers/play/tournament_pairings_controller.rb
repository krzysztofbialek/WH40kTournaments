class Play::TournamentPairingsController < ApplicationController
  before_filter :load_tournament
  respond_to :json

  def index
    pairings = @tournament.pairings
    respond_with pairings
  end

  def update
    pairing = @tournament.pairings.find(params[:id])
    if pairing.update_attributes(params[:tournament_pairing].slice(:player1_game_points, :player2_game_points))
      respond_with :status => 200
    else
      render :json => {:msg => pairing.errors.full_messages.join(',')}, :status => 422
    end
  end
end
