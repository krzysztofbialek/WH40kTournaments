#coding: utf-8
class Rank::RankPlacesController < AdminController

  def index
    @places = RankPlace.includes(:player)
  end

end
