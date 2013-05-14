class Post < ActiveRecord::Base
  extend FriendlyId

  belongs_to :user
  belongs_to :tournament

  default_scope :order => 'created_at DESC'
  friendly_id :name, use: [:slugged, :scoped], scope: :tournament

  after_create :notify_players

  def notify_players
    return true if !tournament.new?
    players = tournament.tournament_registrations.where(:email != nil)
    players.each do |p|
      RegistrationsMailer.notify_about_new_post(self, p).deliver
    end
  end

end
