defmodule PreHackUI.Actor do
  use GenServer

  def start_link(_) do
    GenServer.start_link(__MODULE__, nil)
  end

  def init(_) do
    send(self(), {:tick, 0.0})
    {:ok, nil}
  end

  def handle_info({:tick, wave}, state) do
    Phoenix.PubSub.broadcast(PreHackUI.PubSub, "pre-hack-events", {:tick, wave})

    wave = (:math.cos(round(get_milliseconds() / 1000)) + 1) / 2
    Process.send_after(self(), {:tick, wave}, 100)
    {:noreply, state}
  end

  def get_milliseconds do
    {mega, sec, micro} = :os.timestamp()
    (mega * 1_000_000 + sec) * 1000 + round(micro / 1000)
  end
end
