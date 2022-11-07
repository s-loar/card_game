defmodule Cards do
  @moduledoc """
    Provides methods for creating and handling a deck of cards
  """

  @doc """
    Returns a list of strings representing a deck of playing cards

  ## Example

    iex> Cards.create_deck
    ["Ace of Spades", "Two of Spades", "Three of Spades", "Four of Spades",
    "Five of Spades", "Six of Spades", "Ace of Clubs", "Two of Clubs",
    "Three of Clubs", "Four of Clubs", "Five of Clubs", "Six of Clubs",
    "Ace of Hearts", "Two of Hearts", "Three of Hearts", "Four of Hearts",
    "Five of Hearts", "Six of Hearts", "Ace of Diamonds", "Two of Diamonds",
    "Three of Diamonds", "Four of Diamonds", "Five of Diamonds", "Six of Diamonds"]

  """
  def create_deck do
    values = ["Ace", "Two", "Three", "Four", "Five", "Six"]
    suits = ["Spades", "Clubs", "Hearts", "Diamonds"]

    for suit <- suits, value <- values do
       "#{value} of #{suit}"
    end
  end

  @doc """
    Returns a shuffled a deck.
  """
  def shuffle(deck) do
    Enum.shuffle(deck)
  end

  @doc """
    Returns a boolean of whether a card exists in a deck.

  ## Example
      iex> deck = Cards.create_deck
      iex> Cards.contains?(deck, "Ace of Spades")
      true

  """
  def contains?(deck, card) do
    Enum.member?(deck, card)
  end

  @doc """
    Divides the deck into a hand and the remaining cards of the deck.
    The `hand_size` argument is how many cards to put into the hand.

  ## Examples

      iex> deck = Cards.create_deck
      iex> {hand, deck} = Cards.deal(deck, 1)
      iex> hand
      ["Ace of Spades"]

  """
  def deal(deck, hand_size) do
    Enum.split(deck, hand_size)
  end

  @doc """
    Saves a deck to the `filename` parameter.
    By default, if puts it at the root of the project.
  """
  def save(deck, filename) do
    binary = :erlang.term_to_binary(deck)
    File.write(filename, binary)
  end

  @doc """
    Loads and returns a deck from the `filename` parameter.
  """
  def load(filename) do
    case File.read(filename) do
      {:ok, binary} -> :erlang.binary_to_term binary
      {:error, _reason} -> "That file does not exist"
    end
  end

  @spec create_hand(integer) :: {list, list}
  @doc """
    Creates a deck, shuffles that deck, and deals a hand of `hand_size`.
  """
  def create_hand(hand_size) do
    Cards.create_deck
    |> Cards.shuffle
    |> Cards.deal(hand_size)
  end
end
