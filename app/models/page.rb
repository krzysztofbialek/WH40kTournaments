class Page < ActiveRecord::Base
  
  belongs_to :tournament

  validates_presence_of  :title, :content
  validates_format_of   :slug, :with => /^[\w-]+$/, :allow_blank => true

end

