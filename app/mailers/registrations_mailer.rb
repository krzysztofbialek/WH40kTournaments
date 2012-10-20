#coding: utf-8
class RegistrationsMailer < ActionMailer::Base
  default :from => "admin@wh40k-tournaments.com"

  def tournament_signup_confirmation(reg)
    @tournament = reg.tournament
    @player = reg.player
    mail( :to => reg.player_email, :subject => 'Twoje zgłoszenie zostało przyjęte')
  end

end
