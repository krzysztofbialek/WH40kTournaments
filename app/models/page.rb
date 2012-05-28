class Page < ActiveRecord::Base
  
  belongs_to :tournament

  valdates_presence_of  :title, :slug, :content
  validates_format_of   :slug, :with => /^[\w-]+$/

end

