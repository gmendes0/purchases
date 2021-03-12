defmodule Purchases.Purchases.Show do
  alias Purchases.{Item, Purchase, Repo}

  def call(id) do
    case id |> Ecto.UUID.cast do
      {:ok, uuid} ->
        uuid
        |> get_purchase()
      _ ->
        {:error, "Invalid ID"}
    end
  end

  defp get_purchase(uuid) do
    case Purchase |> Repo.get(uuid) |> Repo.preload(:items) do
      %Purchase{} = purchase ->
        {:ok, purchase}
      nil ->
        {:error, "Purchase not found"}
    end
  end
end
