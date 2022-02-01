defmodule DemoAppWeb.PageController do
  use DemoAppWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
