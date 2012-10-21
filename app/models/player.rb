class Player < ActiveRecord::Base
  require 'csv'

  Armies = ['Grey Knights', 'Eldars', 'Chaos Space Marines', 'Space Wolves',
             'Imperial Guard', 'Chaos Demons', 'Blood Angels', 'Dark Angels',
             'Orks', 'Dark Eldars', 'Black Templars', 'Sister of Battle',
             'Tyranids', 'Necrons', 'Tau']

  has_many :tournament_registrations, :dependent => :nullify

  #validates_presence_of :nick
  validates_uniqueness_of :league_id, :allow_blank => true
  validates_format_of :league_id, :with => /^[A-Za-z]{2}\d{3}$/, :allow_blank => true

  def name
    "#{first_name} '#{nick}' #{last_name}"
  end

  def self.import(file)
    CSV.parse(file) do |row|
      user = Player.find_or_initialize_by_league_id(row[0])
      user.update_attributes(  :first_name => row[1], 
                               :last_name => row[2],
                               :nick => row[3],
                               :city => row[4])
      user.save
    end
  end

end
