#encoding: utf-8
class PlayersController < ApplicationController

  before_filter :load_tournament

  def index
    render json: Player.all, root: false
  end
  
  def create
    player = Player.new(params[:player])
    if player.save
      unless @tournament.for_teams?
        registration = @tournament.tournament_registrations.create(:army => params[:army], :player_id => player.id)
        if registration.save
          redirect_to tournament_tournament_registrations_path(@tournament), :notice => "Dodano zgłoszenie"
        else 
          redirect_to :back, :alert => "Nie udało się dodać zgłoszenia"
        end
      end
      redirect_to :back, :alert => "Dodano gracza, możesz dodać go do drużyny"
    else
      redirect_to :back, :alert => "Nie udało się dodać gracza"
    end
  end
      

end
