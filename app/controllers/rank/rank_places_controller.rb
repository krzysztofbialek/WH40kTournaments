#coding: utf-8
class Rank::RankPlacesController < AdminController

  layout 'rank'

  def index
    @places = RankPlace.includes(:player).order('total_points DESC')
  end

end
