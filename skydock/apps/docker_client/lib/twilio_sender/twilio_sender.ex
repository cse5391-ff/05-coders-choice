defmodule DockerClient.TwilioSender do
  use GenServer
  # Client
  def start_link(params) do
    GenServer.start_link(__MODULE__, nil, params)
  end

  def send_response(sms_params, message) do
    GenServer.cast(DockerClient.TwilioSender, {:send_response, sms_params, message})
  end

  # Server (callbacks)
  @impl true
  def init(state) do
    {:ok, state}
  end

  @impl true
  def handle_cast({:send_response, sms_params, message}, _state) do
    response = ExTwilio.Message.create(to: sms_params["From"], from: sms_params["To"], body: message)
    IO.inspect(response)
    {:noreply, nil}
  end

end
