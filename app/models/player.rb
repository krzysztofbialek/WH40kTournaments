class Player < ActiveRecord::Base

  Armies = ['Grey Knights', 'Eldars', 'Chaos Space Marines', 'Space Wolves']

  has_many :tournament_registrations, :dependent => :nullify

  validates_presence_of :nick
  validates_uniqueness_of :league_id
  validates_format_of :league_id, :with => /^\w{2}\d{3}$/

  def name
    "#{first_name} '#{nick}' #{last_name}"
  end

end
