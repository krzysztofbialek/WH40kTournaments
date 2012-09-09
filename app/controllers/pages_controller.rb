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
        redirect_to tournament_page_path(@tournament, @page), notice: 'Page was successfully created.'
      else
        render :new
      end
    end
  end

  def edit
    @page = @tournament.pages.find(params[:id])
  end
  
  def update
    if params[:content]
      tournament = Tournament.find(5)
      page = tournament.pages.find(2)
      value =  ActiveSupport::JSON.decode(params[:content])["undefined"]["value"]
      page.update_attributes(:content => value)

      
      render text: "success"

    else
      @tournament = Tournament.find(params[:tournament])
      @page = @tournament.pages.find(params[:id])
      if @page.update_attributes(params[:page])
        redirect_to tournament_page_path(@tournament, @page), notice: 'Page was successfully updated.'
      else
        render :edit
      end
    end
  end

end
