defmodule Tadpoll.Voting.Vote do
  use Ecto.Schema
  import Ecto.Changeset
  alias Tadpoll.Voting.Vote


  schema "votes" do
    field :selection, :integer
    field :participant_id, :id
    field :poll_id, :id

    timestamps()
  end

  @doc false
  def changeset(%Vote{} = vote, attrs) do
    vote
    |> cast(attrs, [:selection])
    |> validate_required([:selection])
    |> unique_constraint(:participant_id_poll_id, name: :votes_participant_id_poll_id_index)
  end
end
