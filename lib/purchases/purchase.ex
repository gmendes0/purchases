defmodule Purchases.Purchase do
  use Ecto.Schema
  import Ecto.Changeset

  alias Purchases.Item

  @primary_key {:id, :binary_id, autogenerate: true}

  @required_fields [:date, :nfe]

  schema "purchases" do
    field :date, :utc_datetime
    field :nfe, :string

    has_many :items, Item

    timestamps()
  end

  def changeset(struct \\ %__MODULE__{}, params) do
    struct
    |> cast(params, @required_fields)
    |> validate_required(@required_fields)
    |> unique_constraint([:nfe])
  end
end
