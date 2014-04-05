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
  end

  def preview_tournament
    @tournament = Tournament.new(params[:tournament])
    unless @tournament.valid?
      render :upload_results
    end
    @tournament.results_required = false
  end
end
