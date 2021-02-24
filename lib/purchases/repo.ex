defmodule Purchases.Repo do
  use Ecto.Repo,
    otp_app: :purchases,
    adapter: Ecto.Adapters.Postgres
end
