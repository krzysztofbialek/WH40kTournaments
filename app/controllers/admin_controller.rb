#encoding: utf-8
class AdminController < ApplicationController

  before_filter :admin_required
  layout 'admin'

  private

  def admin_required
    unless current_user.try(:admin?)
      redirect_to root_path, :notice => "Musisz być adminem"
    end
  end

end
