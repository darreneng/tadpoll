defmodule Tadpoll.Voting.Poll do
  use Ecto.Schema
  import Ecto.Changeset
  alias Tadpoll.Voting.{Poll, Vote, Participant}


  schema "polls" do
    field :question, :string
    has_many :votes, Vote
    belongs_to :participant, Participant

    timestamps()
  end

  @doc false
  def changeset(%Poll{} = poll, attrs) do
    poll
    |> cast(attrs, [:question])
    |> validate_required([:question])
  end
end
