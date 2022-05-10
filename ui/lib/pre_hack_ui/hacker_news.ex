defmodule PreHackUI.HackerNews do
  @api_base "https://hacker-news.firebaseio.com/v0/"

  @top "topstories.json"
  @new "newstories.json"
  @maxitem "maxitem.json"

  defp item(item_id) do
    "item/#{item_id}.json"
  end

  def get_front_page do
    {:ok, %{body: body}} =
      :get
      |> Finch.build(@api_base <> @top)
      |> Finch.request(PreHack.Finch)

    Jason.decode!(body)
  end

  def get_new do
    {:ok, %{body: body}} =
      :get
      |> Finch.build(@api_base <> @new)
      |> Finch.request(PreHack.Finch)

    Jason.decode!(body)
  end

  def max_item do
    {:ok, %{body: body}} =
      :get
      |> Finch.build(@api_base <> @maxitem)
      |> Finch.request(PreHack.Finch)

    Jason.decode!(body)
  end

  def get_items(item_ids) do
    item_ids
    |> Task.async_stream(&get_item/1)
    |> Enum.map(fn result ->
      {:ok, item} = result
      item
    end)
  end

  def get_item(item_id) do
    {:ok, %{body: body}} =
      :get
      |> Finch.build(@api_base <> item(item_id))
      |> Finch.request(PreHack.Finch)

    Jason.decode!(body)
  end
end
