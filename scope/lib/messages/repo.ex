defmodule Messages.Repo do
  use Ecto.Repo,
    otp_app: :scope,
    adapter: Ecto.Adapters.Postgres
end
