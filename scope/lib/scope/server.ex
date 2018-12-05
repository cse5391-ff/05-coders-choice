defmodule Server do
  use GenServer

  @messages []

  @impl true
  def init(topic) do
    spawn(fn -> receive_msg(topic) end)
    {:ok, %{}}
  end

  def start(topic, key \\ "") do
    spawn(fn -> receive_msg(topic) end)
  end

  def list_messages(:unread) do

  end

  def list_messages(:all) do

  end

  def receive_msg(topic) do
    receive do
      {:urgent, value} ->
        IO.puts "! #{topic} received '#{value}'"
        save_msg("#{:urgent}", [topic: "#{topic}", content: "#{value}"])
        receive_msg(topic)

      {:peripheral, value} ->
        IO.puts "! #{topic} received '#{value}'"
        save_msg("#{:peripheral}", [topic: "#{topic}", content: "#{value}"])
        receive_msg(topic)

      {:normal, value} ->
        IO.puts "o #{topic} received '#{value}'"
        save_msg("#{:peripheral}", [topic: "#{topic}", content: "#{value}"])
        receive_msg(topic)

        value ->
        IO.puts "o #{topic} received '#{value}'"
        receive_msg(topic)
    end
  end

  def save_msg(urgency, payload) do
    msg = %Messages.Message{
      content: payload[:content],
      # timestamps: :calendar.universal_time(),
      # from: payload[:from],
      urgency: urgency,
      server: payload[:topic]
    }
    Messages.Repo.insert(msg)
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
