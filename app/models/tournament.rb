class Tournament < ActiveRecord::Base
  validates_presence_of :name, :start_date, :rank, :city

  has_many :pages, :dependent => :destroy
  has_many :tournament_registrations, :dependent => :destroy
  has_many :posts, :dependent => :destroy
  has_many :hostel_bookings, :dependent => :destroy
end
