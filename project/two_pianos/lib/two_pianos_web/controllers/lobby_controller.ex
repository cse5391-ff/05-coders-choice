defmodule TwoPianosWeb.LobbyController do
  use TwoPianosWeb, :controller

  def index(conn, _params) do
    render conn, "index.html", user_id: UserManager.generate_user_id(_length = 8)
  end

end

