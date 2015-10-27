defmodule HomemadePi.Repo.Migrations.AddRfCodesAndIftttToSwitches do
  use Ecto.Migration

  def change do
    alter table(:switches) do
      add :rf_code_on, :integer
      add :rf_code_off, :integer
      add :ifttt_id, :integer
    end
  end
end
