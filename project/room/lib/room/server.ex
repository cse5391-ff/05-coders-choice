defmodule Room.Server do

  use GenServer

  #TODOS:
  #   * Try to self-destruct rooms after certain amount of time w/o occupants
  #   * Move helpers / state logic stuff into separate module

  ### GENSERVER FUNCTIONS ###

  def init({:protected, user_id}) do

    initial_state = %{
      type:      :protected,
      creator:   user_id,
      occupants: MapSet.new(),
    }

    {:ok, initial_state}

  end

  def init({:match, {user_id1, user_id2}}) do

    initial_state = %{
      type:      :match,
      permitted: MapSet.new([user_id1, user_id2]),
      occupants: MapSet.new(),
    }

    {:ok, initial_state}

  end

  def handle_call({:join, user_id}, _from, state) do
    cond do
      room_full?(state)                 -> {:reply, {:failure, "room full"}, state}
      user_authorized?(user_id, state)  -> {:reply, :success, state |> add_occupant(user_id)}
      true                              -> {:reply, {:failure, "unauthorized"}, state}
    end
  end

  def handle_cast({:leave, user_id}, state) do
    updated_occupants = state.occupants |> MapSet.delete(user_id)
    {:noreply, %{state | occupants: updated_occupants}}
  end

  ### HELPERS ###

  defp add_occupant(state, user_id), do: %{state | occupants: state.occupants |> MapSet.put(user_id)}
  defp room_full?(state),            do: MapSet.size(state.occupants) == 2
  defp room_empty?(state),           do: MapSet.size(state.occupants) == 0

  defp creator_present?(state = %{type: :protected}), do: state.occupants |> MapSet.member?(state.creator)

  #defp user_authorized?(user_id, state = %{type: :match, permitted: permitted_users})
  #  when user_id in permitted_users
  #do
  #  true
  #end

  defp user_authorized?(user_id, state = %{type: :match}), do: user_id in state.permitted

  defp user_authorized?(user_id, state = %{type: :protected}) do
    cond do
      room_empty?(state)                      -> true
      protected_authorized?(user_id, state)   -> true
      true                                    -> false
    end
  end

  defp protected_authorized?(user_id, _state = %{type: :protected, creator: user_id}), do: true
  defp protected_authorized?(_user_id, state = %{type: :protected}),                   do: state |> creator_present?()



end
