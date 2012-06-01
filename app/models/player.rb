class Player < ActiveRecord::Base

  has_many :tournament_registrations, :dependent => :nullify

  def name
    "#{first_name} '#{nick}' #{last_name}"
  end
end
