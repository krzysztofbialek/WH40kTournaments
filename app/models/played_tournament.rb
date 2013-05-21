class PlayedTournament < ActiveRecord::Base
  attr_accessible :place, :player_id, :points, :tournament_id
end
