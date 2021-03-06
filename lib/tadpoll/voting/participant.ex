defmodule Tadpoll.Voting.Participant do
  use Ecto.Schema
  import Ecto.Changeset
  alias Tadpoll.Voting.{Participant, Vote, Poll}


  schema "participants" do
    has_many :votes, Vote
    has_many :polls, Poll
    belongs_to :user, Tadpoll.Accounts.User

    timestamps()
  end

  @doc false
  def changeset(%Participant{} = participant, attrs) do
    participant
    |> cast(attrs, [])
    |> validate_required([])
  end
end
