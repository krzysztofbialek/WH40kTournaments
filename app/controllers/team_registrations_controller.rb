#encoding: utf-8
class TeamRegistrationsController < ApplicationController
  
  before_filter :load_tournament, :load_pages
 
  def index
    @registrations = TeamRegistration.includes([:team]).order('accepted DESC, accepted_at ASC, created_at ASC ')
    @team = Team.new
  end 

  def destroy
    reg = @tournament.team_registrations.find(params[:id])   
    if reg.destroy
      redirect_to tournament_tournament_registrations_path(@tournament), :notice => "Zgłoszenie usunięte"
    end
  end
  
  def create
    registration = @tournament.team_registrations.new(params[:team_registration])
    if registration.save
      redirect_to :back, :notice => "Dodano zgłoszenie"
    else
      redirect_to :back, :alert => "Nie udało się dodać zgłoszenia"
    end
  end
  
  def update
    @team_registration = @tournament.team_registrations.find(params[:id])
    if @team_registration.update_attributes(params[:team_registration])
      redirect_to tournament_tournament_registrations_path(@tournament), :notice => "Zgłoszenie uaktualnione"
    else
      render :edit, :alert => "Nie udało się uaktualnić zgłoszenia"
    end
  end
  
  def toggle
    reg = @tournament.team_registrations.find(params[:id])
    val = reg.send(params[:action_type])
    reg.send("#{params[:action_type]}=", !val)
    reg.save
    redirect_to :back, notice: 'Zgłoszenie uaktualnione'
  end

end 
