defmodule Skydock.TwilioSender do
  use GenServer
  # Client
  def start_link(name \\ nil) do
    GenServer.start_link(__MODULE__, nil, [name: name])
  end

  def send_message(pid, recipient, message) do
    GenServer.cast(pid, {:send_message, recipient})
  end

  # Server (callbacks)
  @impl true
  def init(state) do
    {:ok, state}
  end

  @impl true
  def handle_cast({:send_message, recipient, message}, _state) do
    response = ExTwilio.Message.create(to: recipient, from: "+13093798162", body: message)
    IO.inspect(response)
    {:noreply, nil}
  end

end
