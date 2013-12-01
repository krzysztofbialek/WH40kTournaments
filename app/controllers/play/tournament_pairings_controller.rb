class Play::TournamentPairingsController < ApplicationController
  before_filter :load_tournament
  respond_to :json

  def show
    pairing = TournamentPairing.find(params[:id])
    respond_with pairing
  end

  def index
    if @tournament.for_teams?
      @pairings = @tournament.team_pairings.order('tournament_team_pairings.table ASC')
    else
      @pairings = @tournament.pairings.order('tournament_pairings.table ASC')
    end
    render json: @pairings, root: false
  end

  def update
    if @tournament.for_teams?
      pairing = @tournament.team_pairings.find(params[:id])
      if pairing.update_attributes(params.slice(:team1_game_points, :team2_game_points, :team1_match_points, :team2_match_points, :team1_id, :team2_id))
        respond_with :status => 200
      else
        render :json => {:msg => pairing.errors.full_messages.join(',')}, :status => 422
      end
    else
      pairing = @tournament.pairings.find(params[:id])
      if pairing.update_attributes(params[:tournament_pairing].slice(:player1_game_points, :player2_game_points, :player1_id, :player2_id))
        respond_with :status => 200
      else
        render :json => {:msg => pairing.errors.full_messages.join(',')}, :status => 422
      end
    end
    
  end
end
