defmodule PurchasesWeb.PurchasesView do
  def render("200.json", %{purchases: purchases}) do
    purchases
    |> Enum.map(fn purchase ->
      purchase
      |> Map.from_struct()
      |> Map.drop([:__meta__, :items])
    end)
  end

  def render("200.json", %{purchase: %{items: items} = purchase}) do
    purchase = purchase
    |> Map.from_struct()
    |> Map.drop([:__meta__])

    %{purchase | items: Enum.map(items, fn item ->
      item
      |> Map.from_struct()
      |> Map.drop([:__meta__, :purchase])
    end)}
  end

  def render("201.json", %{purchase: purchase}) do
    purchase
    |> Map.from_struct()
    |> Map.drop([:__meta__, :items])
  end
end
