defmodule Purchases.Repo.Migrations.CreateItemsTable do
  use Ecto.Migration

  def change do
    create table :items do
      add :code, :integer
      add :name, :string
      add :quantity, :decimal
      add :unit, :string
      add :unitary_value, :decimal

      add :purchase_id, references(:purchases)

      timestamps
    end
  end
end
