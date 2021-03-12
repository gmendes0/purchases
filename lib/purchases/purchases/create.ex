defmodule Purchases.Purchases.Create do
  alias Purchases.{Purchase, Repo}

  def call(params) do
    params
    |> Purchase.changeset()
    |> Repo.insert()
  end
end
