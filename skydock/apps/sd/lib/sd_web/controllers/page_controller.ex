defmodule SdWeb.PageController do
  use SdWeb, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end

  def handle_sms(conn, params) do
    DockerClient.CommandHandler.get_containers(params) #change to commandparser
    send_resp(conn, 200, "Ok")
  end

end
