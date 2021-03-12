defmodule PurchasesWeb.ItemsView do
  def render("200.json", %{items: items}) do
    items
    |> Enum.map(fn purchase ->
      purchase
      |> Map.from_struct()
      |> Map.drop([:__meta__, :purchase])
    end)
  end

  def render("200.json", %{item: item}) do
    item
    |> Map.from_struct()
    |> Map.drop([:__meta__, :purchase])
  end

  def render("201.json", %{item: item}) do
    item
    |> Map.from_struct()
    |> Map.drop([:__meta__, :purchase])
  end
end
