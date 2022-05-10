defmodule PreHackUI.Article do
  use Ecto.Schema
  import Ecto.Changeset

  schema "articles" do
    field(:item, :map)

    timestamps()
  end

  def changeset(item, item_data) do
    item
    |> cast(%{item: item_data}, [:item])
    |> validate_required([:item])
  end

  def upsert(item_id, item_data) do
    article =
      case PreHackUI.Repo.get(__MODULE__, item_id) do
        nil -> %__MODULE__{}
        article -> article
      end

    article
    |> changeset(item_data)
    |> PreHackUI.Repo.insert_or_update!()
  end
end
