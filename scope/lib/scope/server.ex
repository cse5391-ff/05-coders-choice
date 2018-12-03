defmodule Scope.Server do
  use GenServer

  @messages []


  defmodule Message do
    defstruct(
      content: "",
      from: "",
      urgency: [:urgent, :peripheral, :normal],
      timestamps: :calendar.universal_time()
    )
  end

  @impl true
  def init(topic) do
    Phoenix.PubSub.subscribe(:servers, topic)
    {:ok, %{}}
  end

  def list_messages(:unread) do

  end

  def list_messages(:all) do

  end

  def send_message(:urgent, payload) do
    %Scope.Server.Message{
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

  def handle_call(:send_message, topic, payload) do
    {:noreply, topic, payload}
  end

  def save_msg(payload) do
    {:noreply, payload}
  end

end
