defmodule ScrabbleWeb.PageController do
  use ScrabbleWeb, :controller

  def index(request, _params) do
    request
    |> render("index.html")
  end
end
