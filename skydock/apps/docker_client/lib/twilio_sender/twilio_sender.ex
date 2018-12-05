defmodule DockerClient.TwilioSender do
  use GenServer
  # Client
  def start_link(params) do
    GenServer.start_link(__MODULE__, nil, params)
  end

  def send_message(recipient, message) do
    GenServer.cast(DockerClient.TwilioSender, {:send_message, recipient, message})
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
