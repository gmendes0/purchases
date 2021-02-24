defmodule Purchases.Users.Create do
  def call(params) do
    params
    |> Purchases.User.changeset
    |> Purchases.Repo.insert
  end
end
