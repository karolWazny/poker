defmodule Poker do

  def create_deck do
    values = ["Ace", "Two", "Three", "Four", "Five", "Six", "Seven", "Eight", "Nine", "Ten", "Queen", "Jack", "King"]
    suits = ["Spades", "Clubs", "Hearts", "Diamonds"]

    for suit <- suits, value <- values do
      %{value: value, suit: suit}
    end
  end

  def shuffle(deck) do
    Enum.shuffle(deck)
  end

  @doc """
  Determines whether a deck contains a given card.

  ## Examples

      iex> deck = Poker.create_deck
      iex> Poker.contains?(deck, %{value: "Ace", suit: "Spades"})
      true

      iex> deck = Poker.create_deck
      iex> Poker.contains?(deck, "Ace of Spades")
      false

  """
  def contains?(deck, card) do
    Enum.member?(deck, card)
  end

  @doc """
  ## Examples
      iex> Poker.parse_card_string "Ace of Spades"
      %{value: "Ace", suit: "Spades"}
  """
  def parse_card_string(card) do
    [value, suit] = String.split(card, " of ", trim: true)
    %{value: value, suit: suit}
  end

  @doc """
  Divides a deck into a hand and the remainder of the deck.
  The `hand_size` argument indicates how many cards should
  be in the hand.

  ## Examples

      iex> deck = Poker.create_deck
      iex> {hand, _deck} = Poker.deal(deck, 1)
      iex> hand
      [%{value: "Ace", suit: "Spades"}]

  """
  def deal(deck, hand_size) do
    Enum.split(deck, hand_size)
  end

  def save(deck, filename) do
    binary = :erlang.term_to_binary(deck)
    File.write(filename, binary)
  end

  def load(filename) do
    case File.read(filename) do
      { :ok, binary } -> :erlang.binary_to_term binary
      { :error, _reason } -> "That file does not exist"
    end
  end

  def create_hand(hand_size) do
    Poker.create_deck
    |> Poker.shuffle
    |> Poker.deal(hand_size)
  end

end
