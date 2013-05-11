#coding: utf-8
class RegistrationsMailer < ActionMailer::Base
  default :from => "admin@wh40k-tournaments.com"

  def tournament_signup_confirmation(reg)
    @tournament = reg.tournament
    @player = reg.player
    mail( :to => reg.player_email, :subject => 'Twoje zgłoszenie zostało przyjęte')
  end

  def tournament_change_confirmation(reg, change)
    @tournament = reg.tournament
    @player = reg.player
    mail( :to => reg.player_email, 
          :subject => "Aktualizacja Twojego zgłoszenia na #{@tournament.name }", 
          :template_name => change)
  end
end
