defmodule Tadpoll.Voting.Participant do
  use Ecto.Schema
  import Ecto.Changeset
  alias Tadpoll.Voting.Participant


  schema "participants" do

    timestamps()
  end

  @doc false
  def changeset(%Participant{} = participant, attrs) do
    participant
    |> cast(attrs, [])
    |> validate_required([])
  end
end
