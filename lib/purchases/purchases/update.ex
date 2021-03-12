defmodule Purchases.Purchases.Update do
  alias Purchases.{Purchase, Repo}

  def call(%{"id" => id} = params) do
    id
    |> Purchases.get_purchase()
    |> update_purchase(params |> Map.drop(["id"]))
  end

  defp update_purchase({:ok, %Purchase{} = purchase}, params) do
    purchase
    |> Purchase.changeset(params)
    |> Repo.update()
  end

  defp update_purchase({:error, _something} = error, _params), do: error
end
