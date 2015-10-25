defmodule HomemadePi.SwitchControllerTest do
  use HomemadePi.ConnCase

  alias HomemadePi.Switch
  @valid_attrs %{name: "some content", state: true}
  @invalid_attrs %{}

  setup do
    conn = conn() |> put_req_header("accept", "application/json")
    {:ok, conn: conn}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, switch_path(conn, :index)
    assert json_response(conn, 200)["data"] == []
  end

  test "shows chosen resource", %{conn: conn} do
    switch = Repo.insert! %Switch{}
    conn = get conn, switch_path(conn, :show, switch)
    assert json_response(conn, 200)["data"] == %{"id" => switch.id,
      "name" => switch.name,
      "state" => switch.state}
  end

  test "does not show resource and instead throw error when id is nonexistent", %{conn: conn} do
    assert_raise Ecto.NoResultsError, fn ->
      get conn, switch_path(conn, :show, -1)
    end
  end

  test "creates and renders resource when data is valid", %{conn: conn} do
    conn = post conn, switch_path(conn, :create), switch: @valid_attrs
    assert json_response(conn, 201)["data"]["id"]
    assert Repo.get_by(Switch, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, switch_path(conn, :create), switch: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "updates and renders chosen resource when data is valid", %{conn: conn} do
    switch = Repo.insert! %Switch{}
    conn = put conn, switch_path(conn, :update, switch), switch: @valid_attrs
    assert json_response(conn, 200)["data"]["id"]
    assert Repo.get_by(Switch, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    switch = Repo.insert! %Switch{}
    conn = put conn, switch_path(conn, :update, switch), switch: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "deletes chosen resource", %{conn: conn} do
    switch = Repo.insert! %Switch{}
    conn = delete conn, switch_path(conn, :delete, switch)
    assert response(conn, 204)
    refute Repo.get(Switch, switch.id)
  end
end
