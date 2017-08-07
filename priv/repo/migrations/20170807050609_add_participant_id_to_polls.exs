defmodule Tadpoll.Repo.Migrations.AddParticipantIdToPolls do
  use Ecto.Migration

  def change do
    alter table(:polls) do
      add :participant_id, references(:participants, on_delete: :delete_all),
                      null: false
    end

    create index(:polls, [:participant_id])
  end
end
