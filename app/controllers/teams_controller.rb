class TeamsController < ApplicationController

  def index
    @teams = Teams.all
  end
  
  def destroy
    team = Team.find(params[:id])   
    if team.destroy
      redirect_to team_registrations_path, :notice => "team deleted"
    end
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

  def edit
    @team = Team.find(params[:id])
    @registration = @team.team_registration
  end

  def update
    @registration = TeamRegistration.find(params[:id])
    @team = @registration.team

    if @team.update_attributes(params[:team])
      redirect_to team_registrations_path, :notice => "Team updated"
    else
      render :edit, :notice => "Failed to update team"
    end
  end
end
