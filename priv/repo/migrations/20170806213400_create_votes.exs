defmodule Tadpoll.Repo.Migrations.CreateVotes do
  use Ecto.Migration

  def change do
    create table(:votes) do
      add :selection, :integer
      add :participant_id, references(:participants, on_delete: :delete_all), null: false
      add :poll_id, references(:polls, on_delete: :delete_all), null: false

      timestamps()
    end

    create index(:votes, [:participant_id])
    create index(:votes, [:poll_id])

    # Enforce unique pair of voter and poll
    create unique_index(:votes, [:participant_id, :poll_id])
  end
end
