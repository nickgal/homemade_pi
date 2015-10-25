defmodule HomemadePi.SwitchController do
  use HomemadePi.Web, :controller

  alias HomemadePi.Switch

  plug :scrub_params, "switch" when action in [:create, :update]

  def index(conn, _params) do
    switches = Repo.all(Switch)
    render(conn, "index.json", switches: switches)
  end

  def create(conn, %{"switch" => switch_params}) do
    changeset = Switch.changeset(%Switch{}, switch_params)

    case Repo.insert(changeset) do
      {:ok, switch} ->
        conn
        |> put_status(:created)
        |> put_resp_header("location", switch_path(conn, :show, switch))
        |> render("show.json", switch: switch)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(HomemadePi.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    switch = Repo.get!(Switch, id)
    render(conn, "show.json", switch: switch)
  end

  def update(conn, %{"id" => id, "switch" => switch_params}) do
    switch = Repo.get!(Switch, id)
    changeset = Switch.changeset(switch, switch_params)

    case Repo.update(changeset) do
      {:ok, switch} ->
        HomemadePi.Endpoint.broadcast! "switches:lobby", "update", HomemadePi.SwitchView.render("switch.json", %{switch: switch})
        render(conn, "show.json", switch: switch)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(HomemadePi.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    switch = Repo.get!(Switch, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(switch)

    send_resp(conn, :no_content, "")
  end
end
