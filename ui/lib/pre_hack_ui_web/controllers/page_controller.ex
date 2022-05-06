defmodule PreHackUIWeb.PageController do
  use PreHackUIWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
