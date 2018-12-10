defmodule Sudoku.Game.GeneratePuzzle do
  use GenServer
  def start_link(game) do
    GenServer.start_link(__MODULE__, game, name: __MODULE__)
  end

  def generate_puzzle do
    GenServer.call __MODULE__, :generate_puzzle
  end

  def init(game) do
    { :ok, game }
  end

  def handle_call(:generate_puzzle, _from, game) do
    game = game |> Sudoku.Game.Generator.generate_puzzle()
    { :reply, game, game}
  end

  # def handle_call(:generate_puzzle, _from, game) do
  #   { :reply, game, game + 1}
  # end



end
