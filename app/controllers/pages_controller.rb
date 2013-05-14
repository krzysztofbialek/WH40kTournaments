#encoding: utf-8

class PagesController < ApplicationController
  before_filter :load_tournament, :except => ['update']
  before_filter :load_pages
  
  def show
    @page = @tournament.pages.find(params[:id])
  end

  def new
    @page = @tournament.pages.new
  end
  
  def create
  
    if params[:content]
      #authenticate admin here
      allowed_models = ['Page']
      @hash = {}
      ActiveSupport::JSON.decode(params[:content]).each do |key, val|
        model, id, field = key.split('-')
        @hash[model] = {} if @hash[model].blank?
        @hash[model][id] = {} if @hash[model][id].blank?
        @hash[model][id].merge!({field => val['value']})
      end

      @hash.each_pair do |class_name, object|
        if allowed_models.include? class_name
          class_name.constantize.find(object.keys[0]).update_attributes object.values[0]
        end
      end
      render text: "success"

    else
      @page = @tournament.pages.new(params[:page])
      if @page.save
        redirect_to tournament_page_path(@tournament, @page), notice: 'Sekcja została dodana.'
      else
        render :new
      end
    end
  end

  def edit
    @page = @tournament.pages.find(params[:id])
  end

  def destroy
    page = @tournament.pages.find(params[:id])
    if page.destroy
      redirect_to tournament_path(@tournament), notice: 'Sekcja usunięta.'
    else
      redirect_to tournament_page_path(@tournament, @page), notice: 'Nie można usunąć sekcji.'
    end
  end
  
  def update
    if params[:content]
      tournament = Tournament.find(params[:tournament_id])
      page = tournament.pages.find(params[:id])
      page.title = params[:content][:page_name][:value]
      page.content = params[:content][:page_content][:value]
      page.save!
      
      render text: ""

    else
      @tournament = Tournament.find(params[:tournament])
      @page = @tournament.pages.find(params[:id])
      if @page.update_attributes(params[:page])
        redirect_to tournament_page_path(@tournament, @page), notice: 'Sekcja została uaktualniona.'
      else
        render :edit
      end
    end
  end

end
