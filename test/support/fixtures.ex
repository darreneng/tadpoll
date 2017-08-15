defmodule TadpollWeb.Fixtures do
  @moduledoc """
  Set of fixtures for TadpollWeb modules
  """

  alias Tadpoll.{Voting, Accounts}

  @user_attrs %{name: "some name", username: "some username", credential: %{email: "some@email.com"}}
  @poll_attrs %{question: "some question"}

  def fixture(:user) do
    {:ok, user} = Accounts.create_user(@user_attrs)
    user
  end

  def fixture(:poll, assoc \\ []) do
    participant = assoc[:participant] || Voting.ensure_participant_exists(fixture(:user))
    {:ok, poll} = Voting.create_poll(participant, @poll_attrs)
    poll
  end
end