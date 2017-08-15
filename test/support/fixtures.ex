defmodule TadpollWeb.Fixtures do
  @moduledoc """
  Set of fixtures for TadpollWeb modules
  """

  alias Tadpoll.{Voting, Accounts}

  @user_attrs %{name: "some name", username: "some username", credential: %{email: "some@email.com"}}
  @poll_attrs %{question: "some question"}

  def fixture(schema, attrs \\ [])

  def fixture(:user, _) do
    {:ok, user} = Accounts.create_user(@user_attrs)
    user
  end

  def fixture(:participant, attrs) do
    user = attrs[:user] || fixture(:user)
    Voting.ensure_participant_exists(user)
  end

  def fixture(:poll, attrs) do
    participant = attrs[:participant] || fixture(:participant)
    {:ok, poll} = Voting.create_poll(participant, @poll_attrs)
    poll
  end
end