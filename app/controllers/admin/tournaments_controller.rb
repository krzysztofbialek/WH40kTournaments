#encoding: utf-8

class Admin::TournamentsController < AdminController

  def index
    @tournaments = Tournament.all(:order => 'start_date DESC')
  end

  def add_to_rank
    tournament = Tournament.find(params[:id])
 
    if tournament.add_to_rank 
      redirect_to admin_tournaments_path, :notice => "Turniej dodany do rankingu"
    else
      redirect_to admin_tournaments_path, :notice => "Nie udało się dodać do rankungu"
    end
  end
end
