defmodule MapSetStore.DynamicSupervisor do

  use DynamicSupervisor

  def init(_arg) do
    DynamicSupervisor.init(strategy: :one_for_one)
  end

  def start_link(arg) do
    DynamicSupervisor.start_link(__MODULE__, arg)
  end

  def start_child(supervisor_name, id, child_name) do
    supervisor_name |> DynamicSupervisor.start_child(%{id: id, start: {MapSetStore, :start, [child_name]}})
  end

  def child_spec(opts) do
    %{
      id:      __MODULE__,
      start:   {__MODULE__, :start_link, [opts]},
      type:    :supervisor,
      restart: :permanent,
      shutdown: 500
    }
  end

end
