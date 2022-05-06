defmodule PreHackUIWeb.PreHackLive do
  use PreHackUIWeb, :live_view

  def mount(_params, _session, socket) do
    Phoenix.PubSub.subscribe(PreHackUI.PubSub, "pre-hack-events")
    {:ok, assign(socket, waves: [], color: [])}
  end

  def handle_info({:tick, wave}, socket) do
    waves = Enum.take(socket.assigns.waves, 99)

    %{hex: color} =
      Chameleon.HSV.new(round(wave * 100), 100, 100) |> Chameleon.convert(Chameleon.Hex)

    {:noreply, assign(socket, waves: [wave | waves], color: color)}
  end
end
