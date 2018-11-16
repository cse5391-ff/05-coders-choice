defmodule Api.UserView do
  use Api, :view

  def render("show.json", %{user: user}) do
    %{user: user}
  end

  def render("jwt.json", %{token: jwt}) do
    %{token: jwt}
  end

  def render("error.json", %{error: error}) do
    %{error: error}
  end

end
