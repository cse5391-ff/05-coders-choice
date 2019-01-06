defmodule MapStore.DynamicSupervisor do

  use DynamicSupervisor

  def init(_arg) do
    DynamicSupervisor.init(strategy: :one_for_one)
  end

  def start_link(arg) do
    DynamicSupervisor.start_link(__MODULE__, arg, name: __MODULE__)
  end

  # Look back into id after done... Not sure what it's for.
  def start_child(id, name) do
    DynamicSupervisor.start_child(__MODULE__, %{id: id, start: {MapStore, :start, [name]}})
  end

  def child_spec(opts) do
    %{
      id:       __MODULE__,
      start:   {__MODULE__, :start_link, [opts]},
      type:    :supervisor,
      restart: :permanent,
      shutdown: 500
    }
  end

end
