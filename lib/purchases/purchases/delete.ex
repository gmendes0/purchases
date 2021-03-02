defmodule Purchases.Purchases.Delete do
  alias Purchases.{Purchase, Repo}

  def call(id) do
    id
    |> Purchases.get_purchase()
    |> delete_purchase()
  end

  defp delete_purchase({:ok, %Purchase{} = purchase}) do
    purchase
    |> Repo.delete()
  end

  defp delete_purchase({:error, _something} = error), do: error
end
