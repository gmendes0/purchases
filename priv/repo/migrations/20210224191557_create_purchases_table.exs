defmodule Purchases.Repo.Migrations.CreatePurchasesTable do
  use Ecto.Migration

  def change do
    create table :purchases do
      add :date, :utc_datetime
      add :nfe, :string

      timestamps
    end
  end
end
