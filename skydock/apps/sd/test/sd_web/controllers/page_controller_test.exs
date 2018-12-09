defmodule SdWeb.PageControllerTest do
  use SdWeb.ConnCase

  test "GET /", %{conn: conn} do
    conn = get conn, "/"
    assert html_response(conn, 200) =~ "Welcome to Phoenix!"
  end

  test "POST /sms", %{conn: conn} do
    conn = post conn, "/sms"
    assert html_response(conn, 200) =~ "Webhook SMS Received"
  end
end
