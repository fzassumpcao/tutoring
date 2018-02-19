defmodule TutoringWeb.PageController do
  use TutoringWeb, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
