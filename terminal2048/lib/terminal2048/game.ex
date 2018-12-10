defmodule Terminal2048.Game do

  use GenServer

  @me __MODULE__

  def start_link() do
    GenServer.start_link(__MODULE__, [], name: @me)
  end

  def new_game() do
    GenServer.call(@me, :new_game)
  end

  def place_number(board) do
    GenServer.call(@me, {:place_number, board})
  end

  def make_move(game, direction) do
    GenServer.call(@me, {:make_move, game, direction})
  end

  def draw_current_board(game) do
    GenServer.call(@me, {:draw_current_board, game})
  end

  # Implementation
  def init([]) do
    {:ok, Terminal2048.Board.new_game()}
  end

  def handle_call(:new_game, _from, state) do
    {:reply, Terminal2048.Board.new_game(), state}
  end

  def handle_call({:place_number, board}, _from, state) do
    {:reply, Terminal2048.Board.place_number(board), state}
  end

  def handle_call({:make_move, game, direction}, _from, state) do
    {:reply, Terminal2048.Board.make_move(game, direction), state}
  end

  def handle_call({:draw_current_board, game}, _from, state) do
    {:reply, Terminal2048.Board.draw_current_board(game), state}
  end

end
