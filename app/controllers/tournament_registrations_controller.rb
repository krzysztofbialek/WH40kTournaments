#encoding: utf-8
class TournamentRegistrationsController < ApplicationController

  before_filter :load_tournament, :load_pages

  def index
    @player = Player.new
    if @tournament.for_teams?
      @registrations = @tournament.team_registrations.order('paid_at is NULL, paid_at ASC, created_at ASC')
      @team_registration = @tournament.team_registrations.new
      @tournament.team_members_count.times { @team_registration.team_registration_players.build }
    else
      @registrations = @tournament.tournament_registrations.includes([:player]).order('paid_at is NULL, paid_at ASC, created_at ASC')
      @tournament_registration = @tournament.tournament_registrations.new
      @players = Player.find(:all, :order => ('last_name ASC'))
    end 
  end

  def create
    registration = TournamentRegistration.new(params[:tournament_registration])
    if registration.save
      redirect_to :back, :notice => "Dodano zgłoszenie"
    else
      redirect_to :back, :alert => "Nie udało się dodać zgłoszenia"
    end
  end

  def edit
    if @tournament.for_teams?
      @team_registration = @tournament.team_registrations.find(params[:id])
    else
      @registration = @tournament.tournament_registrations.find(params[:id])
    end
  end
  
  def update
    @registration = TournamentRegistration.find(params[:id])
    if @registration.update_attributes(params[:tournament_registration])
      redirect_to tournament_tournament_registrations_path(@tournament), :notice => "Zgłoszenie uaktualnione"
    else
      render :edit, :alert => "Nie udało się uaktualnić zgłoszenia"
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
    if reg.payment_send 
      reg.payment_send = false 
      reg.paid_at = nil
    else
      reg.payment_send = true
      reg.paid_at = Time.now
    end
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
