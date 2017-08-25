defmodule TadpollWeb.VoteController do
  use TadpollWeb, :controller

  alias Tadpoll.Voting
  alias TadpollWeb.PollView

  def create(conn, %{"vote" => vote_params, "poll_id" => poll_id}) do
    participant = conn.assigns.current_participant
    poll = Voting.get_poll!(poll_id)
    case Voting.create_vote(participant, poll, vote_params) do
      {:ok, _vote} ->
        conn
        |> put_flash(:info, "Vote successfully cast")
        |> redirect(to: poll_path(conn, :show, poll))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, PollView, "show.html", poll: poll, vote_changeset: changeset)
    end
  end
  
  def update(conn, _) do
    conn
  end

  def delete(conn, _) do
    conn
  end
end
