defmodule Room.DynamicSupervisor do

  use DynamicSupervisor

  # Called to determine how to start this supervisor up (call start_link w/ args).
  # Will need to forward supervisor's name to start_link through opts
  def child_spec(opts) do
    %{
      id:      __MODULE__,
      start:   {__MODULE__, :start_link, [opts]},
      type:    :supervisor,
      restart: :permanent,
      shutdown: 500
    }
  end

  def start_link(_) do
    DynamicSupervisor.start_link(__MODULE__, :ok, name: __MODULE__)
  end

  def init(:ok) do
    DynamicSupervisor.init(strategy: :one_for_one)
  end

  def start_child(room_name, type, startup_state) do

    %{workers: num_workers} = DynamicSupervisor.count_children(__MODULE__)

    c_spec = %{
      id:    "r#{num_workers + 1}" |> String.to_atom(),
      start: {Room, :start, [room_name, type, startup_state]}
    }

    DynamicSupervisor.start_child(__MODULE__, c_spec)

  end

end
