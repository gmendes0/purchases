defmodule Purchases.Items.Update do
  alias Ecto.Multi
  alias Purchases.{Item, Purchase, Repo}

  def call(%{"purchase_id" => purchase_id, "id" => id} = params) do
    Multi.new()
    |> Multi.run(:purchase, fn repo, _changes ->
      case cast_uuid purchase_id do
        {:ok, uuid} ->
          get_purchase(repo, uuid)
        {:error, _} = error ->
          error
      end
    end)
    |> Multi.run(:item, fn repo, _changes ->
      get_item repo, id
    end)
    |> Multi.run(:update_item, fn repo, %{item: item} ->
      update_item repo, item, Map.drop(params, ["purchase_id"])
    end)
    |> transaction()
  end

  defp cast_uuid(id) do
    case Ecto.UUID.cast id do
      {:ok, uuid} ->
        {:ok, uuid}
      _ ->
        {:error, "Invalid ID"}
    end
  end

  defp get_purchase(repo, uuid) do
    case repo.get(Purchase, uuid) do
      %Purchase{} = purchase ->
        {:ok, purchase}
      nil ->
        {:error, "Purchase not found"}
    end
  end

  defp get_item(repo, uuid) do
    case cast_uuid uuid do
      {:ok, id} ->
        case repo.get Item, id do
          nil ->
            {:error, "Item not found"}
          %Item{} = item ->
            {:ok, item}
        end
      {:error, _} = error ->
        error
    end
  end

  defp update_item(repo, item, params) do
    item
    |> Item.changeset(params)
    |> repo.update()
  end

  defp transaction(multi) do
    case Repo.transaction(multi) do
      {:ok, %{update_item: item}} ->
        {:ok, item}
      {:error, _failed_operation, failed_value, _changes_so_far} ->
        {:error, failed_value}
    end
  end
end
