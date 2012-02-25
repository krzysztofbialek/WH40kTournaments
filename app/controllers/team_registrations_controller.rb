class TeamRegistrationsController < ApplicationController
 
  def index
    @registrations = TeamRegistration.find(:all, :include => [:team])
    @team = Team.new
  end 

  def toggle_payment
    reg = TeamRegistration.find(params[:id])
    reg.payment? ? reg.payment = false : reg.payment = true
    reg.save
    redirect_to team_registrations_path
  end

end 
