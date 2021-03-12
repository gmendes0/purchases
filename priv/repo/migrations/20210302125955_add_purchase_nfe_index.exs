defmodule Purchases.Repo.Migrations.AddPurchaseNfeIndex do
  use Ecto.Migration

  def change do
    create index(:purchases, [:nfe], unique: true)
  end
end
