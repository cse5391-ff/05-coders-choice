defmodule TwoPianosWeb.LobbyController do
  use TwoPianosWeb, :controller

  def index(conn, _params) do
    render conn, "index.html", user_id: IdManager.generate_id(_type = :user, _length = 8)
  end

end

