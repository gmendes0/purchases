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

  defdelegate create_user(params), to: UsersCreate, as: :call

  defdelegate create_purchase(params), to: PurchasesCreate, as: :call
  defdelegate get_purchases, to: PurchasesIndex, as: :call
end
