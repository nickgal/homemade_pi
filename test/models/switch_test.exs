defmodule HomemadePi.SwitchTest do
  use HomemadePi.ModelCase

  alias HomemadePi.Switch

  @valid_attrs %{name: "some content", state: true}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Switch.changeset(%Switch{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Switch.changeset(%Switch{}, @invalid_attrs)
    refute changeset.valid?
  end
end
