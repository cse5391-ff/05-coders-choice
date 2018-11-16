defmodule HooptasticWeb.Router do
  use HooptasticWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", HooptasticWeb do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
    resources "/dashboard", DashboardController, only: [:index]
    resources "/weekly", WeeklyController, only: [:index]
    resources "/season", SeasonController, only: [:index]
    resources "/players", PlayersController, only: [:index]
  end

  # Other scopes may use custom stacks.
  # scope "/api", HooptasticWeb do
  #   pipe_through :api
  # end
end
