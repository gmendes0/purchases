defmodule Purchases.Items.Delete do
  alias Ecto.Multi
  alias Purchases.{Item, Purchase, Repo}

  def call(%{"purchase_id" => purchase_id, "items" => items_ids}) do
    Multi.new()
    |> Multi.run(:purchase, fn repo, _changes ->
      case cast_uuid purchase_id do
        {:ok, uuid} ->
          get_purchase(repo, uuid)
        {:error, _} = error ->
          error
      end
    end)
    |> Multi.run(:items, fn repo, _changes ->
      Enum.each(items_ids, fn item_id ->
        fetch_and_delete_item repo, item_id
      end)

      {:ok, "deleted"}
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

  defp cast_uuid(id) do
    case Ecto.UUID.cast id do
      {:ok, uuid} ->
        {:ok, uuid}
      _ ->
        {:error, "Invalid ID"}
    end
  end

  defp fetch_and_delete_item(repo, uuid) do
    case cast_uuid uuid do
      {:ok, id} ->
        case repo.get Item, id do
          %Item{} = item ->
            delete_item repo, item
          nil -> {:ok, "Already deleted"}
        end
      {:error, _} = error ->
        error
    end
  end

  defp delete_item(repo, %Item{} = item) do
    case repo.delete item do
      {:ok, struct} ->
        {:ok, struct}
      {:error, _} = error ->
        error
    end
  end

  defp transaction(multi) do
    case Repo.transaction(multi) do
      {:ok, _changes} ->
        {:ok, "deleted"}
      {:error, _failed_operation, failed_value, _changes_so_far} ->
        {:error, failed_value}
    end
  end
end
