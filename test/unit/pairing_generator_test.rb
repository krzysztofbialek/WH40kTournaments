require 'test_helper'

class PairingGeneratorTest < ActiveSupport::TestCase
  PG = PairingGenerator

  test "creation of initial pairing (first round)" do
    player1 = PG::Player.new(1, 0)
    player2 = PG::Player.new(2, 0)
    player3 = PG::Player.new(3, 0)
    player4 = PG::Player.new(4, 0)

    odd_players = [player1, player2, player3]

    result = PG.new(odd_players, []).generate(1)

    assert_equal 2, result.size
    assert result.last.player_1.is_a?(PG::Player)
    assert result.last.player_2 == nil

    even_players = [player1, player2, player3, player4]

    result = PG.new(even_players, []).generate(1)

    assert_equal 2, result.size
    assert result.last.player_1.is_a?(PG::Player)
    assert result.last.player_2.is_a?(PG::Player)
  end

  test "creation of pairing in secong round - odd" do
    player1 = PG::Player.new(1, 9)
    player2 = PG::Player.new(2, 13)
    player3 = PG::Player.new(3, 11)

    existing_pairings = [
      PG::Pairing.new(player1, player3)
    ]

    odd_players = [player1, player2, player3]

    result = PairingGenerator.new(odd_players, existing_pairings).generate(2)

    assert_equal 2, result.size

    assert_equal player2, result.first.player_1 
    assert_equal player3, result.first.player_2

    assert_equal player1, result.last.player_1 
    assert_equal nil, result.last.player_2
  end

  test "creation of pairing in secong round - even" do
    player1 = PG::Player.new(1, 9)
    player2 = PG::Player.new(2, 13)
    player3 = PG::Player.new(3, 11)
    player4 = PG::Player.new(4, 7)

    existing_pairings = [
      PG::Pairing.new(player1, player3),
      PG::Pairing.new(player2, player4)
    ]

    even_players = [player1, player2, player3, player4]

    result = PairingGenerator.new(even_players, existing_pairings).generate(2)

    assert_equal 2, result.size

    assert_equal player2, result.first.player_1 
    assert_equal player3, result.first.player_2

    assert_equal player1, result.last.player_1 
    assert_equal player4, result.last.player_2


  end
end
