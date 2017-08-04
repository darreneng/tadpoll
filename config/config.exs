# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :tadpoll,
  ecto_repos: [Tadpoll.Repo]

# Configures the endpoint
config :tadpoll, TadpollWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "/ScZghmsxaXRUIQYqXW0M7JeWubrRw+1KZ/4pzLhooY9pZQF0W2ZSMbNkaefnHN9",
  render_errors: [view: TadpollWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Tadpoll.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
