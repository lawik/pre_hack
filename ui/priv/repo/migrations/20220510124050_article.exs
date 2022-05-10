defmodule PreHackUI.Repo.Migrations.Article do
  use Ecto.Migration

  def change do
    create table(:articles) do
      add(:item, :map)

      timestamps()
    end
  end
end
