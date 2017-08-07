defmodule Tadpoll.Repo.Migrations.AddUserIdToParticipants do
  use Ecto.Migration

  def change do
    alter table(:participants) do
      add :user_id, references(:users, on_delete: :delete_all), null: false
    end

    create unique_index(:participants, [:user_id])
  end
end
