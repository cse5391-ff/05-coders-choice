defmodule Accounts.EnsureAuth do
  import Plug.Conn

  def init(opts), do: opts

  def call(conn, _opts) do
    if conn.assigns.current_user do
      conn
    else
      conn
      |> put_resp_header("content-type", "application/json")
      |> send_resp(401, "Unauthorized")
    end
  end
end
