defmodule SkydockWeb.Router do
  use SkydockWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    # plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", SkydockWeb do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index

    post "/sms", PageController, :handle_sms # Twilio Webhook
  end

  # Other scopes may use custom stacks.
  # scope "/api", SkydockWeb do
  #   pipe_through :api
  # end
end
