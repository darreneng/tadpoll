defmodule TadpollWeb.Router do
  use TadpollWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", TadpollWeb do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index

    resources "/users", UserController
    resources "/sessions", SessionController, only: [:new, :create, :delete],
                                              singleton: true
  end

  scope "/", TadpollWeb do
    pipe_through [:browser, :authenticate_user, :require_existing_participant]

    resources "/polls", PollController do
      resources "/votes", VoteController, only: [:create, :delete, :update]
    end
  end

  defp authenticate_user(conn, _) do
    case get_session(conn, :user_id) do
      nil ->
        conn
        |> Phoenix.Controller.put_flash(:error, "Login required")
        |> Phoenix.Controller.redirect(to: "/")
        |> halt()
      user_id ->
        assign(conn, :current_user, Tadpoll.Accounts.get_user!(user_id))
    end
  end

  defp require_existing_participant(conn, _) do
    participant = Tadpoll.Voting.ensure_participant_exists(conn.assigns.current_user)
    assign(conn, :current_participant, participant)
  end
end
