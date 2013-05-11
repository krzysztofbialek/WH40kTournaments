#coding: utf-8
class Admin::PlayersController < AdminController

  def index
    @players = Player.order('league_id')
  end

  def destroy
  end

  def import
    Player.import(params[:file].read)
    redirect_to admin_players_path, :notice => "Import zakończony"
  end

end
