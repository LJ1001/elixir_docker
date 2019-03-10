defmodule ElixirDocker.Repo do
  use Ecto.Repo,
    otp_app: :elixir_docker,
    adapter: Ecto.Adapters.Postgres
end
