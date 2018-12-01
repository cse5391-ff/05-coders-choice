defmodule TwoPianos.UserController do

  use TwoPianos.Web, :controller
  alias TwoPianos.User

  def index(conn, _params) do
    users = Repo.all(User)
    render(conn, "index.html", users: users)
  end

end
