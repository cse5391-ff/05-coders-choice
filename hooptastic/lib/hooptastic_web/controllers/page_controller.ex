defmodule HooptasticWeb.PageController do
  use HooptasticWeb, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
