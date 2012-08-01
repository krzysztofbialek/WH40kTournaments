class Player < ActiveRecord::Base
  require 'csv'

  Armies = ['Grey Knights', 'Eldars', 'Chaos Space Marines', 'Space Wolves']

  has_many :tournament_registrations, :dependent => :nullify

  validates_presence_of :nick
  validates_uniqueness_of :league_id
  validates_format_of :league_id, :with => /^[A-Za-z]{2}\d{3}$/

  def name
    "#{first_name} '#{nick}' #{last_name}"
  end

  def self.import(file)
    CSV.parse(file) do |row|
      user = Player.find_or_initialize_by_league_id(row[0])
      if user.new_record?
        user.update_attributes(:first_name => row[1], 
                               :last_name => row[2],
                               :nick => row[3],
                               :city => row[4])
        user.save
      end
    end
  end

end
