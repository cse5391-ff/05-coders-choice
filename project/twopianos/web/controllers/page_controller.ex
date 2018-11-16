defmodule Twopianos.PageController do
  use Twopianos.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
