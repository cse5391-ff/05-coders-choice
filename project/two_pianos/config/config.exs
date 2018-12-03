# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# Configures the endpoint
config :two_pianos, TwoPianosWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "d5q0R+IhGtGvRUHuS07QdYUpkjcyHot63HXcpS8ZG5PJmupXaEos530689b98zjR",
  render_errors: [view: TwoPianosWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: TwoPianos.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:user_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
