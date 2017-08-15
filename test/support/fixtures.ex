defmodule Tadpoll.Fixtures do
  @moduledoc """
  Set of fixtures for TadpollWeb modules
  """

  alias Tadpoll.{Voting, Accounts}

  @doc """
  Creates a fixture

  ## Examples

      iex> fixture(:user)
      %User{...}

      iex> fixture(:user, [field: value])
      %User{field: value, ...}

  """
  def fixture(schema, attrs \\ [])

  @user_attrs %{name: "some name", username: "some username", credential: %{email: "some@email.com"}}

  def fixture(:user, attrs) do
    {:ok, user} =
      attrs
      |> Enum.into(@user_attrs)
      |> Accounts.create_user()

    user
  end

  @credential_attrs %{email: "some@email.com"}

  def fixture(:credential, _) do
    fixture(:user).credential
  end

  def fixture(:participant, attrs) do
    user = attrs[:user] || fixture(:user)
    Voting.ensure_participant_exists(user)
  end

  @poll_attrs %{question: "some question"}

  def fixture(:poll, attrs) do
    {participant, attrs} =
      attrs
      |> Enum.into(@poll_attrs)
      |> Enum.into(%{})
      |> Map.pop(:participant)

    participant = participant || fixture(:participant)
    {:ok, poll} = Voting.create_poll(participant, attrs)
    poll
  end
end