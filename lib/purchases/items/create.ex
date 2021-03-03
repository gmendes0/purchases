defmodule Purchases.Items.Create do
  alias Ecto.Multi
  alias Purchases.{Item, Purchase, Repo}

  def call(%{"purchase_id" => purchase_id, "items" => items}) do
    Multi.new()
    |> Multi.run(:purchase, fn repo, _changes ->
      case Ecto.UUID.cast purchase_id do
        {:ok, uuid} ->
          get_purchase(repo, uuid)
        _ ->
          {:error, "Invalid ID"}
      end
    end)
    |> Multi.run(:insert_items, fn repo, %{purchase: purchase} ->
      insert_items(repo, purchase.id, items)
    end)
    |> transaction()
  end

  defp get_purchase(repo, uuid) do
    case repo.get(Purchase, uuid) do
      %Purchase{} = purchase ->
        {:ok, purchase}
      nil ->
        {:error, "Purchase not found"}
    end
  end

  defp insert_items(repo, purchase_id, [%{} | _tail] = items) do
    inserts = Stream.map(items, fn item ->
      item
      |> Map.put("purchase_id", purchase_id)
      |> Item.changeset()
    end)
    |> Enum.map(fn changeset ->
      changeset
      |> repo.insert
    end)

    case Keyword.take(inserts, [:error]) do
      [_head | _tail] = errors ->
        {:error, errors}
      [] ->
        {:ok, inserts}
    end
  end

  defp transaction(multi) do
    case Repo.transaction(multi) do
      {:ok, changes} ->
        {:ok, changes}
      {:error, _failed_operation, failed_value, _changes_so_far} ->
        {:error, failed_value}
    end
  end
end
