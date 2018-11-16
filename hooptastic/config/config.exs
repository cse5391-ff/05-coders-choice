# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :hooptastic,
  ecto_repos: [Hooptastic.Repo]

# Configures the endpoint
config :hooptastic, HooptasticWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "aWln39NHIfp8uhaiMCbGxARAK35jS8PnUnUYKMu+x8LuZ54hiRFbMxfZQNCjY4r2",
  render_errors: [view: HooptasticWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Hooptastic.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:user_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
