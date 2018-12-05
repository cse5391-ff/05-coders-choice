defmodule Server do
  use Agent

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
    spawn(fn -> receive_message(topic) end)
    {:ok, %{}}
  end

  def start(topic) do
    spawn(fn -> receive_message(topic) end)
  end

  def list_messages(:unread) do

  end

  def list_messages(:all) do

  end

  def receive_message(name) do
    receive do
      {:urgent, value} ->
        IO.puts "! #{name} received '#{value}'"
        receive_message(name)
    end
    receive do
      {:peripheral, value} ->
        IO.puts "* #{name} received '#{value}''"
        receive_message(name)
    end
    receive do
      {:normal, value} ->
        IO.puts "o #{name} received '#{value}'"
        receive_message(name)
    end
    receive do
      value ->
        IO.puts "o #{name} received '#{value}'"
        receive_message(name)
    end
  end

  def send_message(:urgent, payload) do
    %Server.Message{
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
