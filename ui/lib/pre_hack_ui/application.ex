defmodule PreHackUI.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    :ok = setup_db!()

    children = [
      # Start the Ecto repository
      PreHackUI.Repo,
      # Start the Telemetry supervisor
      PreHackUIWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: PreHackUI.PubSub},
      # Start the Endpoint (http/https)
      PreHackUIWeb.Endpoint,
      {Finch, name: PreHack.Finch},
      PreHackUI.Actor
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: PreHackUI.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    PreHackUIWeb.Endpoint.config_change(changed, removed)
    :ok
  end

  defp setup_db! do
    repos = Application.get_env(:pre_hack_ui, :ecto_repos)

    for repo <- repos do
      setup_repo!(repo)
      migrate_repo!(repo)
    end

    :ok
  end

  defp setup_repo!(repo) do
    db_file = Application.get_env(:pre_hack_ui, repo)[:database]

    unless File.exists?(db_file) do
      :ok = repo.__adapter__.storage_up(repo.config)
    end
  end

  defp migrate_repo!(repo) do
    {:ok, _, _} = Ecto.Migrator.with_repo(repo, &Ecto.Migrator.run(&1, :up, all: true))
  end
end
