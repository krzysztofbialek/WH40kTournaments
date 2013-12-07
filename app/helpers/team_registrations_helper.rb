module TeamRegistrationsHelper
 
  def players_for(registration)
    content = registration.team_registration_players.map do |p|
      "#{p.player.try(:full_name)} : #{p.try(:army)}"
    end
    content.join("</br>")
  end

end
