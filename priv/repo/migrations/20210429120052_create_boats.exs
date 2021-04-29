defmodule LiveViewStudio.Repo.Migrations.CreateBoats do
  use Ecto.Migration

  def change do
    create table(:boats) do
      add :model, :string
      add :price, :string
      add :image, :string
      add :type, :string

      timestamps()
    end

  end
end
