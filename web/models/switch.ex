defmodule HomemadePi.Switch do
  use HomemadePi.Web, :model

  schema "switches" do
    field :name, :string
    field :state, :boolean, default: false

    timestamps
  end

  @required_fields ~w(name state)
  @optional_fields ~w()

  after_update :send_signal

  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
  end

  def send_signal(changeset) do
    state = changeset |> get_change(:state)
    if is_nil(state) do
    else
      # only for say usage:
      id = changeset |> get_field :id
      name = changeset |> get_field :name
      action = if state, do: "on", else: "off"
      Task.async fn ->
        System.cmd("say", ["Switch #{id}. Turning #{name} #{action}"])
      end
    end
    changeset
  end
end
