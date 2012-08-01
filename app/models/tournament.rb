#encoding: utf-8

class Tournament < ActiveRecord::Base
  TournamentRanks = ['Lokal', 'Czelendżer', 'Master']

  validates_presence_of :name, :start_date, :rank, :city
  
  belongs_to :user
  has_many :pages, :dependent => :destroy
  has_many :tournament_registrations, :dependent => :destroy
  has_many :posts, :dependent => :destroy
  has_many :hostel_bookings, :dependent => :destroy
end
