defmodule HomemadePi.Switch do
  use HomemadePi.Web, :model

  schema "switches" do
    field :name, :string
    field :state, :boolean, default: false
    field :rf_code_on, :integer
    field :rf_code_off, :integer
    field :ifttt_id, :integer

    timestamps
  end

  @required_fields ~w(name state)
  @optional_fields ~w(rf_code_on rf_code_off ifttt_id)

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
      action = if state, do: "on", else: "off"
      code_field = String.to_existing_atom("rf_code_#{action}")
      code = changeset |> get_field code_field

      Task.async fn ->
        if Mix.env == :prod do
          System.cmd("sudo",["codesend", code])
        else
          System.cmd("say", ["Code send #{code}"])
        end
      end
    end
    changeset
  end
end
