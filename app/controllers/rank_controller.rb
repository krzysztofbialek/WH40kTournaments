#encoding: utf-8
class RankController < ApplicationController

  #before_filter :admin_required
  layout 'admin'

  def index
  end

  private

  def admin_required
    unless current_user.try(:admin?)
      redirect_to root_path, :notice => "Musisz być adminem"
    end
  end

end
