defmodule SkydockWeb.PageController do
  use SkydockWeb, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end

  def handle_sms(conn, params) do
    Skydock.CommandHandler.get_containers(CommandHandler, params) #change to commandparser
    send_resp(conn, 200, "Ok")
  end

end
