class ApplicationController < ActionController::Base
  include ControllerAuthentication
  protect_from_forgery

      
  def load_tournament
    @tournament = Tournament.find(params[:tournament_id])
  end

  def load_pages
    @pages = @tournament.pages if @tournament
  end

end
