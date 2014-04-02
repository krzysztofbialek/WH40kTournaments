#coding: utf-8
class Rank::RankPlacesController < AdminController

  layout 'rank'

  def index
    @places = RankPlace.includes(:player).order('total_points DESC')
    if params['sort'] == 'top'
      @places = @places.limit(10)
    end
  end

  def show
    @place = RankPlace.includes(:player).find(params[:id])
    @tournaments = @place.played_tournaments.order('points ASC')
  end

  def upload_results
    @tournament = Tournament.new(params[:tournament])
    if params[:results].present? && params[:results][:upload].present?
      @file = Tournament.import(params[:results][:upload].read)
    end
  end
end
