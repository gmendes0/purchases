defmodule PurchasesWeb.PurchasesController do
  use PurchasesWeb, :controller

  alias Purchases.Purchase

  action_fallback PurchasesWeb.FallbackController

  def index(conn, _params) do
    with [%Purchase{} = _head | _tail] = purchases <- Purchases.get_purchases() do
      conn
      |> put_status(:ok)
      |> render(:"200", purchases: purchases)
    end

    with [] = _purchases <- Purchases.get_purchases() do
      conn
      |> put_status(:ok)
      |> render(:"200", purchases: [])
    end
  end

  def show(conn, %{"id" => id} = _params) do
    with {:ok, struct} <- Purchases.get_purchase(id) do
      conn
      |> put_status(:ok)
      |> render(:"200", purchase: struct)
    end
  end

  def create(conn, params) do
    with {:ok, struct} <- Purchases.create_purchase(params) do
      conn
      |> put_status(:created)
      |> render(:"201", purchase: struct)
    end
  end

  def update(conn, params) do
    with {:ok, struct} <- Purchases.update_purchase(params) do
      conn
      |> put_status(:created)
      |> render(:"201", purchase: struct)
    end
  end

  def delete(conn, %{"id" => id} = _params) do
    with {:ok, _struct} <- Purchases.delete_purchase(id) do
      conn
      |> put_status(204)
      |> text("")
    end
  end
end
