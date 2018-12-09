defmodule TwoPianosWeb.LobbyController do
  use TwoPianosWeb, :controller

  def index(conn, _params) do
    render conn, "index.html", user_id: generate_user_id()
  end

  # MOVE THIS TO SEPARATE MODULE!! IdGenerator or something who knows
  def generate_user_id() do

    #Some random method to generate id
    #Assurance that id is unique
    #return id

    123

  end

end

