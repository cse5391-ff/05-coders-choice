defmodule TwoPianosWeb.RoomController do
  use TwoPianosWeb, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
