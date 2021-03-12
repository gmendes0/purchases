defmodule PurchasesWeb.ItemsController do
  use PurchasesWeb, :controller

  action_fallback PurchasesWeb.FallbackController

  def create(conn, params) do
    with {:ok, _arr} <- Purchases.create_items(params) do
      conn
      |> put_status(:ok)
      |> json(%{ok: true})
    end
  end

  def update(conn, params) do
    with {:ok, item} <- Purchases.update_item(params) do
      conn
      |> put_status(:created)
      |> render(:"200", item: item)
    end
  end

  def delete(conn, params) do
    with {:ok, _} <- Purchases.delete_items(params) do
      conn
      |> put_status(204)
      |> text("")
    end
  end
end
