class AddForTeamsAndTeamMembersCountToTournaments < ActiveRecord::Migration
  def change
    add_column :tournaments, :for_teams, :boolean
    add_column :tournaments, :team_members_count, :integer
  end
end
