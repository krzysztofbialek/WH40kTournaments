#encoding: utf-8

class Tournament < ActiveRecord::Base
  extend FriendlyId
  TournamentRanks = ['Lokal', 'Czelendżer', 'Master']

  validates_presence_of :name, :start_date, :rank, :city
  validates_uniqueness_of :name
  
  belongs_to :user
  has_many :pairings, :class_name => "TournamentPairing"
  has_many :pages, :dependent => :destroy
  has_many :tournament_registrations, :dependent => :destroy
  has_many :posts, :dependent => :destroy
  friendly_id :name, use: :slugged
  #has_many :hostel_bookings, :dependent => :destroy
end
