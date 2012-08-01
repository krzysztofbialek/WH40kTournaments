class TournamentsController < ApplicationController

 def index
  @tournaments = Tournament.all
 end

 def new
  @tournament = Tournament.new 
 end

 def create
   @tournament = Tournament.new(params[:tournament])
   @tournament.user = current_user
   if @tournament.save
     redirect_to tournament_posts_path(@tournament), :notice => "Tournament created"
   else
     render :action => 'new'
   end
 end

end
