defmodule LiveViewStudio.Boats.Boat do
  use Ecto.Schema
  import Ecto.Changeset

  schema "boats" do
    field :image, :string
    field :model, :string
    field :price, :string
    field :type, :string
    timestamps()
  end

  @doc false
  def changeset(boat, attrs) do
    boat
    |> cast(attrs, [:model, :price, :image, :type])
    |> validate_required([:model, :price, :image, :type])
  end
end
