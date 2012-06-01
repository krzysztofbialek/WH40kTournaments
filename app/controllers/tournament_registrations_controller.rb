#encoding: utf-8
class TournamentRegistrationsController < ApplicationController

  before_filter :load_tournament

  def index
    @registrations = TournamentRegistration.includes([:player]).order('created_at ASC ')
    @tournament_registration = @tournament.tournament_registrations.new
    @players = Player.all
    @player = Player.new
  end

  def create
    registration = TournamentRegistration.new(params[:tournament_registration])
    if registration.save
      redirect_to :back, :notice => "Dodano zgłoszenie"
    else
      redirect_to :back, :alert => "Nie udało się dodać zgłoszenia"
    end
  end

  def destroy
    registration = TournamentRegistration.find(params[:id])
    if registration.destroy
      redirect_to tournament_tournament_registrations_path(@tournament), :notice => "Usunięto zgłoszenie"
    else
      redirect_to :back, :notice => "Nie udało się usunąć zgłoszenia"
    end
  end
  
  def toggle_payment
    reg = TournamentRegistration.find(params[:id])
    reg.payment_send? ? reg.payment_send = false : reg.payment_send = true
    reg.save
    redirect_to :back
  end

  def toggle_rosters
    reg = TournamentRegistration.find(params[:id])
    reg.roster_send? ? reg.roster_send = false : reg.roster_send = true
    reg.save
    redirect_to :back
  end

  def toggle_rosters_validation
    reg = TournamentRegistration.find(params[:id])
    reg.roster_valid? ? reg.roster_valid = false : reg.roster_valid = true
    reg.save
    redirect_to :back
  end
end
