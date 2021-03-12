defmodule PurchasesWeb.UserController do
  use PurchasesWeb, :controller

  def store(conn, params) do
    params
    |> Purchases.create_user()
    |> handle_create_response(conn)
  end

  defp handle_create_response({:ok, %Purchases.User{} = user}, conn) do
    conn
    |> put_status(:created)
    |> render(:created, result: user)
  end

  defp handle_create_response({:error, changeset}, conn) do
    conn
    |> put_status(:bad_request)
    |> put_view(PurchasesWeb.ErrorView)
    |> render(:"400", result: changeset)
  end
end
