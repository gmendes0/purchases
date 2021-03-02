defmodule Purchases do
  @moduledoc """
  Purchases keeps the contexts that define your domain
  and business logic.

  Contexts are also responsible for managing your data, regardless
  if it comes from the database, an external API or others.
  """

  alias Purchases.Users.Create, as: UsersCreate
  alias Purchases.Purchases.Create, as: PurchasesCreate
  alias Purchases.Purchases.Index, as: PurchasesIndex
  alias Purchases.Purchases.Show, as: PurchasesShow
  alias Purchases.Purchases.Update, as: PurchasesUpdate
  alias Purchases.Purchases.Delete, as: PurchasesDelete

  defdelegate create_user(params), to: UsersCreate, as: :call

  defdelegate create_purchase(params), to: PurchasesCreate, as: :call
  defdelegate get_purchase(id), to: PurchasesShow, as: :call
  defdelegate get_purchases, to: PurchasesIndex, as: :call
  defdelegate update_purchase(params), to: PurchasesUpdate, as: :call
  defdelegate delete_purchase(id), to: PurchasesDelete, as: :call
end
