defmodule ScopeServer do
  use GenServer

  @impl true
  def init(scope) do
    {:ok, scope}
  end

  def start_link do
    GenServer.start_link(__MODULE__, %{})
  end

  def list_messages(:unread) do

  end

  def send_message(:urgent, payload) do
    %Message.State{
      content: payload.content,
      from: payload.from,
      timestamps: payload.timestamps,
      urgency: payload.urgency
    }
    payload
  end

  def send_message(:peripheral, payload) do
      {:noreply, payload}
  end

  def handle_in("ping", payload, socket) do
    {:reply, {:ok, payload}, socket}
  end

  # It is also common to receive messages from the client and
  # broadcast to everyone in the current topic (chat_room:lobby).
  def handle_in("shout", payload, socket) do
    spawn(fn -> save_msg(payload) end)
    {:noreply, socket}
  end

  def save_msg(payload) do
    {:noreply, payload}
  end

  @impl true
  def handle_info(:after_join, socket) do
    {:noreply, socket}
  end

end
