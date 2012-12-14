class PlaysController < ApplicationController

  before_filter :load_tournament

  layout "play"

  def show
  end

end
