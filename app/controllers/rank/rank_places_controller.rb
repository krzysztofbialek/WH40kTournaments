#coding: utf-8
class Rank::RankPlacesController < AdminController

  layout 'rank'

  def index
    @places = RankPlace.includes(:player).order('total_points DESC')
  end

  def show
    @place = RankPlace.includes(:player).find(params[:id])
    @tournaments = @place.played_tournaments.order('points ASC')
  end

end
