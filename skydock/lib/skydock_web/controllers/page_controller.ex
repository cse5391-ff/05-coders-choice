defmodule SkydockWeb.PageController do
  use SkydockWeb, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end

  def handle_sms(conn, params) do
    # IO.puts(inspect(conn))
    # IO.puts(inspect(params))
    IO.puts(params["Body"])
    send_resp(conn, 200, "Ok")
  end

end
