#encoding: utf-8
class PlayersController < ApplicationController

  def create
    player = Player.new(params[:player])
    if player.save && player.tournament_registrations.create(:army => params[:army], :tournament_id => params[:tournament_id])
      redirect_to :back, :notice => "Dodano zgłoszenie"
    else 
      redirect_to :back, :alert => "Nie udało się dodać zgłoszenia"
    end
  end
      

end
