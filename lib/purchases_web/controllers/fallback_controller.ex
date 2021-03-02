defmodule PurchasesWeb.FallbackController do
  use PurchasesWeb, :controller

  def call(conn, {:error, %Ecto.Changeset{} = changeset}) do
    conn
    |> put_status(:bad_request)
    |> put_view(PurchasesWeb.ErrorView)
    |> render(:"400", changeset: changeset)
  end
end
