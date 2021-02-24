defmodule PurchasesWeb.UserView do
  def render("created.json", %{result: %Purchases.User{id: _id, inserted_at: _inserted_at, updated_at: _updated_at} = result}) do
    result
    |> Map.delete(:__meta__)
    |> Map.delete(:__struct__)
    |> Map.delete(:password)
  end
end
