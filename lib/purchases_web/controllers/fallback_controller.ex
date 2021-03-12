defmodule PurchasesWeb.FallbackController do
  use PurchasesWeb, :controller

  def call(conn, {:error, %Ecto.Changeset{} = changeset}) do
    conn
    |> put_status(:bad_request)
    |> put_view(PurchasesWeb.ErrorView)
    |> render(:"400", changeset: changeset)
  end

  def call(conn, {:error, [{:error, %Ecto.Changeset{}} | _] = changesets}) do
    conn
    |> put_status(:bad_request)
    |> put_view(PurchasesWeb.ErrorView)
    |> render(:"400", changesets: changesets)
  end

  def call(conn, {:error, something}) do
    conn
    |> put_status(:bad_request)
    |> put_view(PurchasesWeb.ErrorView)
    |> render(:"400", result: something)
  end
end
