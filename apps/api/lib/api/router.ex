defmodule Api.Router do
  use Api, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :protected_api do
    plug Accounts.EnsureAuth
  end

  scope "/", Api do
    pipe_through :api

    # API for Authentication
    post "/register", UserController, :create
    post "/login", UserController, :login
    get "/validate", UserController, :validate
  end

end
