defmodule Scope.ChatServer do
  use DynamicSupervisor
  import Supervisor.Spec

  def start_link(opts \\ []) do
    DynamicSupervisor.start_link(__MODULE__, opts, name: __MODULE__)
  end

  def init(init_state \\ []) do
    DynamicSupervisor.init(strategy: :one_for_one)
  end

  def start_child(:new, topic) do
    spec = worker(Channel, [name: topic], [topic: topic, restart: :transient])
    {:ok, channel} = DynamicSupervisor.start_child(__MODULE__, spec)
  end

  # def shoot(unique_name) do
  #   spec = worker(Stackgen, [], [id: unique_name, restart: :transient])
  #   Supervisor.start_child(__MODULE__, spec)
  # end
end
