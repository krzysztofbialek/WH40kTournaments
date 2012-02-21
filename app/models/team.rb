class Team < ActiveRecord::Base

  has_one :team_registration
  
  validates_presence_of :name
  validates_uniqueness_of :name

  after_create :register_team

  def register_team
    TeamRegistration.create(:team => self)
  end
end
