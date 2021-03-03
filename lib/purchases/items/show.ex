defmodule Purchases.Items.Show do
  alias Purchases.{Item, Repo}

  def call(id) do
    case Ecto.UUID.cast(id) do
      {:ok, uuid} ->
        get_item uuid
      _ ->
        {:error, "Invalid ID"}
    end
  end

  defp get_item(uuid) do
    case Repo.get(Item, uuid) do
      %Item{} = item ->
        {:ok, item}
      nil ->
        {:error, "Item not found"}
    end
  end
end
