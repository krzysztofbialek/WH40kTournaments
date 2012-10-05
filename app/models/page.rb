class Page < ActiveRecord::Base
  extend FriendlyId
  belongs_to :tournament

  validates_presence_of  :title, :content
  validates_format_of   :slug, :with => /^[\w-]+$/, :allow_blank => true
  
  friendly_id :title, use: [:slugged, :scoped], scope: :tournament

end

