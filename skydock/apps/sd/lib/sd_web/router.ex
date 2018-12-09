defmodule SdWeb.Router do
  use SdWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", SdWeb do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index

    post "/sms", PageController, :handle_sms # Twilio Webhook

    get "/media/:name", PageController, :handle_media # Twilio Requesting image
  end

  # Other scopes may use custom stacks.
  # scope "/api", SdWeb do
  #   pipe_through :api
  # end
end
