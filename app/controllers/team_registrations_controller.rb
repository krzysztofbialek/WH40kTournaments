class TeamRegistrationsController < ApplicationController
 
  def index
    @registrations = TeamRegistration.includes([:team]).order('accepted DESC, accepted_at ASC, created_at ASC ')
    @team = Team.new
  end 

  def destroy
    reg = TeamRegistration.find(params[:id])   
    if reg.destroy
      redirect_to team_registrations_path, :notice => "registration deleted"
    end
  end


  def toggle_payment
    reg = TeamRegistration.find(params[:id])
    reg.payment? ? reg.payment = false : reg.payment = true
    reg.save
    redirect_to team_registrations_path
  end
  
  def toggle_accept
    reg = TeamRegistration.find(params[:id])
    reg.accepted_at? ? reg.accepted_at = nil : reg.accepted_at = Time.now
    reg.accepted? ? reg.accepted = nil : reg.accepted = true
    reg.save
    redirect_to team_registrations_path
  end

  def toggle_rosters
    reg = TeamRegistration.find(params[:id])
    reg.rosters? ? reg.rosters = false : reg.rosters = true
    reg.save
    redirect_to team_registrations_path
  end

  def toggle_rosters_validation
    reg = TeamRegistration.find(params[:id])
    reg.rosters_valid? ? reg.rosters_valid = false : reg.rosters_valid = true
    reg.save
    redirect_to team_registrations_path
  end
end 
