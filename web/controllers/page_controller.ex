defmodule HomemadePi.PageController do
  use HomemadePi.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
