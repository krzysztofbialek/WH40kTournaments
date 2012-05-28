class PagesController < ApplicationController
  before_filter :load_tournament, :load_pages
  
  def show
    @page = @tournament.pages.find(params[:id])
  end

  def new
    @page = @tournament.pages.new
  end
  
  def create
    @page = @tournament.pages.new(params[:page])
    if @page.save
      redirect_to tournament_page_path(@tournament, @page), notice: 'Page was successfully created.'
    else
      render :new
    end
  end

  def edit
  end
  
  def update
  end

end
