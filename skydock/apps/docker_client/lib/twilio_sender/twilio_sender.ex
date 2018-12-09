defmodule DockerClient.TwilioSender do
  use GenServer
  # Client
  def start_link(params) do
    GenServer.start_link(__MODULE__, nil, params)
  end

  def send_sms(to, from, body) do
    GenServer.cast(DockerClient.TwilioSender, {:send_sms, to, from, body})
  end

  def send_sms_response(sms_params, message) do
    GenServer.cast(DockerClient.TwilioSender, {:send_sms_response, sms_params, message})
  end

  def send_mms(to, from, body, mediaUrl) do
    GenServer.cast(DockerClient.TwilioSender, {:send_mms, to, from, body, mediaUrl})
  end

  def send_mms_response(sms_params, message, mediaUrl) do
    GenServer.cast(DockerClient.TwilioSender, {:send_mms_response, sms_params, message, mediaUrl})
  end

  # Server (callbacks)
  @impl true
  def init(state) do
    {:ok, state}
  end

  @impl true
  def handle_cast({:send_sms,  to, from, body}, _state) do
    response = ExTwilio.Message.create(to: to, from: from, body: body)
    IO.inspect(response)
    {:noreply, nil}
  end

  @impl true
  def handle_cast({:send_sms_response, sms_params, message}, _state) do
    response = ExTwilio.Message.create(to: sms_params["From"], from: sms_params["To"], body: message)
    IO.inspect(response)
    {:noreply, nil}
  end

  @impl true
  def handle_cast({:send_mms,  to, from, body, mediaUrl}, _state) do
    response = ExTwilio.Message.create(to: to, from: from, body: body, mediaUrl: mediaUrl)
    IO.inspect(response)
    {:noreply, nil}
  end

  @impl true
  def handle_cast({:send_mms_response, sms_params, message, mediaUrl}, _state) do
    response = ExTwilio.Message.create(to: sms_params["From"], from: sms_params["To"], body: message, mediaUrl: mediaUrl)
    IO.inspect(response)
    {:noreply, nil}
  end

end
