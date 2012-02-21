class TeamRegistrationsController < ApplicationController
 
  def index
    @registrations = TeamRegistration.find(:all, :include => [:team])
    @team = Team.new
  end 

end 
