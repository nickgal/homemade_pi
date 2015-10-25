defmodule HomemadePi.Repo.Migrations.CreateSwitch do
  use Ecto.Migration

  def change do
    create table(:switches) do
      add :name, :string
      add :state, :boolean, default: false

      timestamps
    end

  end
end
