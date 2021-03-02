defmodule PurchasesWeb.PurchasesView do
  def render("200.json", %{purchases: purchases}) do
    purchases
    |> Enum.map(fn purchase ->
      purchase
      |> Map.from_struct()
      |> Map.drop([:__meta__])
    end)
  end

  def render("201.json", %{purchase: purchase}) do
    purchase
    |> Map.from_struct()
    |> Map.drop([:__meta__])
  end
end
