defmodule Connect4Web.PageController do
  use Connect4Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
