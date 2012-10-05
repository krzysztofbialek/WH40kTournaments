class Post < ActiveRecord::Base
  extend FriendlyId

  belongs_to :user
  belongs_to :tournament

  default_scope :order => 'created_at DESC'
  friendly_id :name, use: [:slugged, :scoped], scope: :tournament

end
