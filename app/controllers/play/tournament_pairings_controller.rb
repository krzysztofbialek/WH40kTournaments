class Play::TournamentPairingsController < ApplicationController
  before_filter :load_tournament
  respond_to :json

  def index
    pairings = @tournament.pairings
    respond_with pairings
  end

end
