defmodule Tadpoll.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias Tadpoll.Accounts.{User, Credential}


  schema "users" do
    field :name, :string
    field :username, :string
    has_one :credential, Credential

    timestamps()
  end

  @doc false
  def changeset(%User{} = user, attrs) do
    user
    |> cast(attrs, [:name, :username])
    |> validate_required([:name, :username])
    |> unique_constraint(:username)
  end
end
