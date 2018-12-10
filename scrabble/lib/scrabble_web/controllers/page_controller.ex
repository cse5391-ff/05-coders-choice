defmodule ScrabbleWeb.PageController do
  use ScrabbleWeb, :controller

  def index(request, _params) do
    request
    |> render("index.html")
  end

  def show(conn, %{"word" => word}) do
    wordlist = Scrabble.new_help(word)
    text(conn, "list: #{wordlist}")
  end
end
