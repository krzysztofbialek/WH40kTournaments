FactoryGirl.define do
  factory :tournament do
    name          "Syrenka"
    start_date    2.days.from_now
    rank          "Master"
    city          "Warszawa"
  end

  factory :pairing, class: TournamentPairing do
    association :tournament, factory: :tournament
    association :player1, factory: :player  
    association :player2, factory: :player, league_id: 'WW002'
  end

  factory :player do
    first_name   "Albert" 
    last_name    "Motyka"
    nick         "Hatchet"
    league_id    "WW001"
  end

end
