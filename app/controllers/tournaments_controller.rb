class TournamentsController < ApplicationController

 def index
  @tournaments = Tournament.all
 end

 def new
  @tournament = Tournament.new 
 end

 def create
   @tournament = Tournament.new(params[:tournament])
   if @tournament.save
     redirect_to tournaments_path, :notice => "Tournament created"
   else
     render :action => 'new'
   end
 end

end
