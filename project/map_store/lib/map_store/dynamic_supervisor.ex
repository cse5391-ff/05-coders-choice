defmodule MapStore.DynamicSupervisor do

  use DynamicSupervisor

  ### STARTUP ###

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

  # Called on supervisor process start_up
  def start_link(opts) do
    DynamicSupervisor.start_link(__MODULE__, opts)
  end

  # Callback run as part of start_link / after start_link? returns supervisor specification
  def init(_) do
    DynamicSupervisor.init(strategy: :one_for_one)
  end

  ### CALLABLE ###

  # Creates named MapSetStore.Server under specified MapSetStore Supervisor
  def start_child(supervisor_name, child_name) do

    child_num = DynamicSupervisor.count_children(supervisor_name) + 1

    c_spec = %{
      id:    "ms#{child_num}" |> String.to_atom(),
      start: {MapStore, :start, [child_name]}
    }

    DynamicSupervisor.start_child(supervisor_name, c_spec)

  end

end
