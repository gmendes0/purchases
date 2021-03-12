defmodule Purchases.Purchases.Index do
  alias Purchases.{Purchase, Repo}

  def call() do
    Purchase
    |> Repo.all
  end
end
