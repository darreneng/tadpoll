defmodule TadpollWeb.PollController do
  use TadpollWeb, :controller

  alias Tadpoll.Voting
  alias Tadpoll.Voting.Poll

  plug :require_existing_participant
  plug :authorize_poll when action in [:edit, :update, :delete]

  def index(conn, _params) do
    polls = Voting.list_polls()
    render(conn, "index.html", polls: polls)
  end

  def new(conn, _params) do
    changeset = Voting.change_poll(%Poll{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"poll" => poll_params}) do
    case Voting.create_poll(conn.assigns.current_participant, poll_params) do
      {:ok, poll} ->
        conn
        |> put_flash(:info, "Poll created successfully.")
        |> redirect(to: poll_path(conn, :show, poll))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    poll = Voting.get_poll!(id)
    render(conn, "show.html", poll: poll)
  end

  def edit(conn, %{"id" => id}) do
    poll = Voting.get_poll!(id)
    changeset = Voting.change_poll(poll)
    render(conn, "edit.html", poll: poll, changeset: changeset)
  end

  def update(conn, %{"poll" => poll_params}) do
    poll = conn.assigns.poll

    case Voting.update_poll(poll, poll_params) do
      {:ok, poll} ->
        conn
        |> put_flash(:info, "Poll updated successfully.")
        |> redirect(to: poll_path(conn, :show, poll))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", poll: poll, changeset: changeset)
    end
  end

  def delete(conn, _) do
    {:ok, _poll} = Voting.delete_poll(conn.assigns.poll)

    conn
    |> put_flash(:info, "Poll deleted successfully.")
    |> redirect(to: poll_path(conn, :index))
  end

  defp require_existing_participant(conn, _) do
    participant = Voting.ensure_participant_exists(conn.assigns.current_user)
    assign(conn, :current_participant, participant)
  end

  defp authorize_poll(conn, _) do
    poll = Voting.get_poll!(conn.params["id"])

    if conn.assigns.current_participant.id == poll.participant_id do
      assign(conn, :poll, poll)
    else
      conn
      |> put_flash(:error, "You can't modify that page")
      |> redirect(to: poll_path(conn, :index))
      |> halt()
    end
  end
end
