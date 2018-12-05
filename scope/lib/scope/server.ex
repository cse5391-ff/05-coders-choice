defmodule Server do
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
    spawn(fn -> receive_message(topic) end)
    {:ok, %{}}
  end

  def start(topic, key \\ "") do
    spawn(fn -> receive_message(topic) end)
  end

  def list_messages(:unread) do

  end

  def list_messages(:all) do

  end

  def receive_message(topic) do
    receive do
      {:urgent, value} ->
        IO.puts "! #{topic} received '#{value}'"
        msg = %Messages.Message{
          content: "#{value}",
          server: "#{topic}",
          urgency: "#{:urgent}"
        }
        Messages.Repo.insert(msg)
        receive_message(topic)
    end
    receive do
      {:peripheral, value} ->
        IO.puts "* #{topic} received '#{value}''"
        receive_message(topic)
    end
    receive do
      {:normal, value} ->
        IO.puts "o #{topic} received '#{value}'"
        receive_message(topic)
    end
    receive do
      value ->
        IO.puts "o #{topic} received '#{value}'"
        receive_message(topic)
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
