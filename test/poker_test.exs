defmodule PokerTest do
  use ExUnit.Case
  doctest Poker

  test "create_deck makes 52 cards" do
    deck_length = length(Poker.create_deck)
    assert deck_length == 52
  end

  test "shuffling a deck randomizes it" do
    deck = Poker.create_deck
    refute deck == Poker.shuffle(deck)
  end

end
