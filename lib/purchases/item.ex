defmodule Purchases.Item do
  use Ecto.Schema

  import Ecto.Changeset

  alias Purchases.Purchase

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id

  @required_fields [:code, :name, :quantity, :unit, :unitary_value, :purchase_id]

  schema "items" do
    field :code, :integer
    field :name, :string
    field :quantity, :decimal
    field :unit, :string
    field :unitary_value, :decimal

    belongs_to :purchase, Purchase

    timestamps()
  end

  def changeset(struct \\ %__MODULE__{}, params) do
    struct
    |> cast(params, @required_fields)
    |> validate_required(@required_fields)
  end
end
