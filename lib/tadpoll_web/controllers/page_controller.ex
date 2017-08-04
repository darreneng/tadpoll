defmodule TadpollWeb.PageController do
  use TadpollWeb, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
