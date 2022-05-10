defmodule PreHackUIWeb.PreHackLive do
  use PreHackUIWeb, :live_view

  def mount(_params, _session, socket) do
    Phoenix.PubSub.subscribe(PreHackUI.PubSub, "pre-hack-events")

    %{frontpage: frontpage, new: new, items: items, max_item: max} =
      GenServer.call(PreHackUI.Actor, :get)

    {:ok, assign(socket, frontpage: frontpage, new: new, items: items, max_item: max)}
  end

  def handle_info({:frontpage, frontpage}, socket) do
    {:noreply, assign(socket, frontpage: frontpage)}
  end

  def handle_info({:new, new}, socket) do
    {:noreply, assign(socket, new: new)}
  end

  def handle_info({:max_item, max}, socket) do
    {:noreply, assign(socket, max_item: max)}
  end

  def handle_info({:items, items}, socket) do
    {:noreply, assign(socket, items: items)}
  end
end
