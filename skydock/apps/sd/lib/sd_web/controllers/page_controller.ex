defmodule SdWeb.PageController do
  use SdWeb, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end

  def handle_sms(conn, sms_params) do
    {command, args} = DockerClient.CommandParser.parse_message(sms_params["Body"])
    command.(sms_params, args)
    send_resp(conn, 200, "Webhook SMS Received")
  end

  def handle_media(conn, %{"name"=>name}) do
    send_file(conn, 200, "/tmp/#{name}")
  end

end
