defmodule User do
  use Agent

  def start_link(init_state \\ []) do
    Agent.start_link(fn -> %{} end)
  end

  def send_msg(topic, message) do
    Phoenix.PubSub.broadcast(
      Scope.PubSub,
      topic,
      {:send_msg, message}
    )
  end

  def request(req, action, result) do
    {:ok, :notimplemented}
  end
end
