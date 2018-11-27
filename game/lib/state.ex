defmodule Game.State do
  defstruct(
    board: [
      0,0,0,0,0,0,
      0,0,0,0,0,0,
      0,0,0,0,0,0,
      0,0,0,0,0,0
    ],
    turn: 0,
    game_state: :none,
    count: 0
  )

  def determine_result(board, new_move) do
    # IO.inspect(new_move["board"])
    horz_check = check_horz(new_move, board)
    vert_check = check_vert(new_move, board)
    diag_check = check_diag(new_move, board)
    full_check = check_full(new_move)


    cond do
      vert_check == true ->
        %{board | game_state: :win, board: new_move["board"], turn: new_move["turn"]}
      horz_check == true ->
        %{board | game_state: :win, board: new_move["board"], turn: new_move["turn"]}
      diag_check == true ->
        %{board | game_state: :win, board: new_move["board"], turn: new_move["turn"]}
      full_check == false ->
        %{board | game_state: :tie, board: new_move["board"], turn: new_move["turn"]}
      true ->
        %{board | game_state: :new_move, board: new_move["board"], turn: new_move["turn"]}
    end

  end

  def check_full(new_move) do
    Enum.member?(new_move["board"], 0)
  end

  def check_horz(new_move, board) do
    check = new_move["board"]
    chip = new_move["turn"]

    check_horz(chip, Enum.chunk_every(check, 6), 0, board)

  end

  def check_horz(chip, [h1 | t1], count, board) do
    if count != 4 do
      check_horz(chip, t1, check(h1, chip), board)
    else
      check_horz(chip, [], count, board)
    end
  end

  def check_horz(_chip, [], count, _board) do
    if count == 4 do
      IO.puts("four")
      true
    else
      IO.puts("nothign")
      false
    end

  end

  def check(list, chip) do
    count = Ex02.new_counter(1)
    IO.inspect(list)
    Enum.each list, fn item ->

      if chip == item do
        # IO.puts("count increments")
        Ex02.next_value(count)
      else
        if Ex02.get_curr(count) != 4 do
          Ex02.reset(count)
        end
      end

    end
    IO.inspect Ex02.get_curr(count)
  end

  def check_vert(new_move, board) do
    check = new_move["board"]
    chip = new_move["turn"]
    cols = div_boardVert(check)

    check_vert(chip, cols, 0, board)

  end

  def div_boardVert(board) do
    count = Ex02.new_counter(0)

    col = div_boardVert(count, board)
    IO.inspect(col)
  end

  def div_boardVert(count, board) do

    Ex02.reset(count)
    c00 = Enum.filter board, fn _item ->
      Ex02.next_value(count)
      rem(Ex02.get_curr(count), 6) == 0
    end

    Ex02.reset(count)
    c01 = Enum.filter board, fn _item ->
      Ex02.next_value(count)
      rem(Ex02.get_curr(count), 6) == 1
    end

    Ex02.reset(count)
    c02 = Enum.filter board, fn _item ->
      Ex02.next_value(count)
      rem(Ex02.get_curr(count), 6) == 2
    end

    Ex02.reset(count)
    c03 = Enum.filter board, fn _item ->
      Ex02.next_value(count)
      rem(Ex02.get_curr(count), 6) == 3
    end

    Ex02.reset(count)
    c04 = Enum.filter board, fn _item ->
      Ex02.next_value(count)
      rem(Ex02.get_curr(count), 6) == 4
    end

    Ex02.reset(count)
    c05 = Enum.filter board, fn _item ->
      Ex02.next_value(count)
      rem(Ex02.get_curr(count), 6) == 5
    end

    [c01, c02, c03, c04, c05, c00]
  end


  def check_vert(chip, [h1 | t1], count, board) do
    if count != 4 do
      check_vert(chip, t1, check(h1, chip), board)
    else
      check_vert(chip, [], count, board)
    end
  end

  def check_vert(_chip, [], count, _board) do
    if count == 4 do
      IO.puts("four")
      true
    else
      IO.puts("nothign")
      false
    end

  end

  def check_diag(new_move, board) do
    chip = new_move["turn"]

    check_diag(chip, new_move["diag"] , 0, board)

  end

  def check_diag(chip, [h1 | t1], count, board) do
    if count != 4 do
      check_diag(chip, t1, check(h1, chip), board)
    else
      check_diag(chip, [], count, board)
    end
  end

  def check_diag(_chip, [], count, _board) do
    if count == 4 do
      IO.puts("four")
      true
    else
      IO.puts("nothign")
      false
    end

  end


end


defmodule Ex02 do


  def new_global_counter(init_val \\ 0) do
    Agent.start_link(fn -> init_val end, name: Global_Counter)
  end

  def global_next_value() do
    Agent.get_and_update(Global_Counter, fn state ->
      new_state = state + 1
      {state, new_state}
    end)
  end


  def new_counter(init_val \\ 0) do
    { :ok, pid} = Agent.start_link(fn -> init_val-1 end)
    pid
  end

  def next_value(pid) do
      Agent.get_and_update(pid, fn state ->
        state = state + 1
        { state, state }
      end)
  end

  def get_curr(pid) do
    Agent.get(pid, &( &1 ))
  end

  def reset(pid) do
    Agent.get_and_update(pid, fn _state ->
      state = 0
      { state, state }
    end)
  end

end
