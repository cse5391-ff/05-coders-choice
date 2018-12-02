defmodule ServerFarm do
  use DynamicSupervisor

  @servers []

  def start_link(arg) do
    DynamicSupervisor.start_link(__MODULE__, arg, name: __MODULE__)
  end

  def save_state(payload) do

  end

  def load_state() do

  end

  def start_child(foo, bar, baz) do
    spec = {Server, foo: foo, bar: bar, baz: baz}
    DynamicSupervisor.start_child(__MODULE__, foo)
  end

  def list_channels do
    {@servers}
  end

  @impl true
  def init(initial_arg) do
    DynamicSupervisor.init(
      strategy: :one_for_many,
      extra_arguments: [initial_arg]
    )
  end

end
