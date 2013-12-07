class PlaysController < ApplicationController

  before_filter :load_tournament

  layout "play"

  def show
    gon.for_teams = @tournament.for_teams?
  end

end
