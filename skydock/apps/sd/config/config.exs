# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :sd,
  namespace: Sd

# Configures the endpoint
config :sd, SdWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "YdKiD+YNSeocQ9HjtMS4T155k79hO+A8Kmt3KAHfOEUD86KiQCMGTlLTE6j1rKvB",
  render_errors: [view: SdWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Sd.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"

config :phoenix, :template_engines,
    md: PhoenixMarkdown.Engine
