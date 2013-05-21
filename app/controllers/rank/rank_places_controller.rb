#coding: utf-8
class Rank::RankPlacesController < AdminController

  def index
    @places = RankPlace.includes(:player).order('total_points DESC')
  end

end
