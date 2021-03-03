defmodule Purchases.Items.Index do
  alias Purchases.{Item, Repo}

  def call() do
    Repo.all Item
  end
end
