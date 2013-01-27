class ApplicationController < ActionController::Base
  include ControllerAuthentication
  protect_from_forgery
      
  def load_tournament
    if params[:tournament_id] 
      @tournament = Tournament.find(params[:tournament_id]) 
    elsif params[:id]
      @tournament = Tournament.find_by_slug(params[:id])
    end
  end

  def load_pages
    @pages = @tournament.pages if @tournament
  end

end
