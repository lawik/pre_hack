defmodule PreHackUI.Repo do
  use Ecto.Repo,
    otp_app: :pre_hack_ui,
    adapter: Ecto.Adapters.SQLite3
end
