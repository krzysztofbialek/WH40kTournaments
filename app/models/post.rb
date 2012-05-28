class Post < ActiveRecord::Base

  belongs_to :user
  belongs_to :tournament

  default_scope :order => 'created_at DESC'

end
