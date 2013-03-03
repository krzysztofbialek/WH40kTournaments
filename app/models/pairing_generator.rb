class PairingGenerator
  def initialize(players, existing_pairings)
    @players = players
    @existing_pairings = existing_pairings
  end

  def generate(round)
    # We don't want to destroy @players, so we make shallow copy
    players_copy = @players.clone

    if round == 1
      players_copy.shuffle!
      pair_players(players_copy)
    elsif round > 1
      players_to_pair = []
      sorted_players = players_copy.sort! { |a,b| b.score <=> a.score }
      while (!sorted_players.empty?)
        player = sorted_players.shift
        players_to_pair << player
        # Find player to pair with only if we can
        if !sorted_players.empty?
          paired_player = player.find_player_to_play_with(sorted_players, @existing_pairings)
          players_to_pair << paired_player
          sorted_players.delete(paired_player)
        end
      end
      pair_players(players_to_pair)      
    else
      raise "Bad round number"
    end
  end

  private

  def pair_players(players)
    paired_players = []
    if players.size.odd?
      players[0..-2].each_slice(2) { |p1, p2| paired_players << Pairing.new(p1, p2) }
      paired_players << Pairing.new(players.last, nil)
    else
      players.each_slice(2) { |p1, p2| paired_players << Pairing.new(p1, p2) }
    end
    paired_players
  end
end

class PairingGenerator::Pairing
  attr_accessor :player_1, :player_2

  def initialize(player_1, player_2)
    @player_1, @player_2 = player_1, player_2
  end
end

class PairingGenerator::Player
  attr_accessor :score, :player_id

  def initialize(player_id, score)
    @score, @player_id = score, player_id
  end

  def find_player_to_play_with(players_to_pair, existing_pairings)
    played_with = existing_pairings.find_all { |p| p.player_1 == self }.map(&:player_2) 
    players_to_pair.find { |p| !played_with.include?(p) }
  end

  def ==(other)
    self.player_id == other.player_id
  end
end