# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :scope,
  ecto_repos: [Scope.Repo]

# Configures the endpoint
config :scope, ScopeWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "M7vlFgF5/qutL1CbHcXy3y24ixYoSZRj3TkLYguYYitDuFAzrS5Bwh35BtI+HgLv",
  render_errors: [view: ScopeWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Scope.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:user_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
