class ChartsController < ApplicationController

  layout 'charts'

  def index
  end

  def massacres
    Player.over_ten_massacres
  end


end