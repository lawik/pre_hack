defmodule PreHackUI.Actor do
  use GenServer

  def start_link(_) do
    GenServer.start_link(__MODULE__, nil, name: PreHackUI.Actor)
  end

  def init(_) do
    send(self(), :load)
    {:ok, %{frontpage: [], new: [], items: %{}, max_item: nil}}
  end

  def handle_call(:get, _from, state) do
    {:reply, state, state}
  end

  def handle_info(:load, state) do
    state =
      state
      |> get_front_page()
      |> get_new()
      |> get_max_item()
      |> get_items()

    Process.send_after(self(), :load, 1000)
    {:noreply, state}
  rescue
    _ ->
      Process.send_after(self(), :load, 1000)
      {:noreply, state}
  end

  defp get_front_page(state) do
    frontpage = PreHackUI.HackerNews.get_front_page()
    Phoenix.PubSub.broadcast(PreHackUI.PubSub, "pre-hack-events", {:frontpage, frontpage})
    %{state | frontpage: frontpage}
  end

  defp get_new(state) do
    new = PreHackUI.HackerNews.get_new()
    Phoenix.PubSub.broadcast(PreHackUI.PubSub, "pre-hack-events", {:new, new})
    %{state | new: new}
  end

  defp get_items(state) do
    item_ids =
      [state.max_item | state.frontpage ++ state.new]
      |> Enum.reject(fn item_id ->
        Map.has_key?(state.items, item_id)
      end)

    items = PreHackUI.HackerNews.get_items(item_ids)

    keyed =
      [item_ids, items]
      |> Enum.zip()
      |> Map.new()
      |> Map.merge(state.items)

    Enum.each(keyed, fn {item_id, item} ->
      if item_id in item_ids do
        PreHackUI.Article.upsert(item_id, item)
      end
    end)

    Phoenix.PubSub.broadcast(PreHackUI.PubSub, "pre-hack-events", {:items, keyed})
    %{state | items: keyed}
  end

  defp get_max_item(state) do
    max = PreHackUI.HackerNews.max_item()
    Phoenix.PubSub.broadcast(PreHackUI.PubSub, "pre-hack-events", {:max_item, max})
    %{state | max_item: max}
  end
end
