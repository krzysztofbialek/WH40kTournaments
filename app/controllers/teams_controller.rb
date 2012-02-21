class TeamsController < ApplicationController

  def index
    @teams = Teams.all
  end
  
  def create
    @team = Team.new(params[:team])
    if @team.save
      redirect_to team_registrations_path, :notice => "Druzyna dodana"
    else
      flash.now[:alert] = "Nie udalo sie dodac druzyny"
      redirect_to team_registrations_path
    end
  end

end
