defmodule CardsServer do
  use GenServer
  @moduledoc """
    Provides methods for creating and handling a deck of cards
  """

  @doc """
    Creates server
  """

  def start_link(state \\ "started") do
    GenServer.start_link(__MODULE__, state, name: __MODULE__)
  end

  def init(state), do: {:ok, state}


  def handle_call({:create_deck, hand_size}, _from, state) do
    hand = Cards.create_hand(hand_size)
    {:reply, hand, state}
  end

  def handle_call({:save_deck, deck, filename}, _from, state) do
    Cards.save(deck, filename)
    {:reply, "Saved", state}
  end

  def handle_call({:load_deck, filename}, _from, state) do
    hand = Cards.load(filename)
    {:reply, hand, state}
  end

  def create_deck(hand_size), do: GenServer.call(__MODULE__, {:create_deck, hand_size})

  def save_deck(deck, filename), do: GenServer.call(__MODULE__, {:save_deck, deck, filename})

  def load_deck(filename), do: GenServer.call(__MODULE__, {:load_deck, filename})

end
