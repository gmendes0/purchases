defmodule Purchases.Purchases do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}

  @required_fields [:date, :nfe]

  schema "purchases" do
    field :date, :utc_datetime
    field :nfe, :string

    timestamps()
  end

  def changeset(params) do
    %__MODULE__{}
    |> cast(params, @required_fields)
    |> validate_required(@required_fields)
  end
end
