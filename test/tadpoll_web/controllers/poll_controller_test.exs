defmodule TadpollWeb.PollControllerTest do
  use TadpollWeb.ConnCase

  import TadpollWeb.Fixtures

  @create_attrs %{question: "some question"}
  @update_attrs %{question: "some updated question"}
  @invalid_attrs %{question: nil}

  describe "index" do
    setup [:logged_in]

    test "lists all polls", %{conn: conn} do
      conn = get conn, poll_path(conn, :index) 
      assert html_response(conn, 200) =~ "Listing Polls"
    end
  end

  describe "new poll" do
    setup [:logged_in]

    test "renders form", %{conn: conn} do
      conn = get conn, poll_path(conn, :new)
      assert html_response(conn, 200) =~ "New Poll"
    end
  end

  describe "create poll" do
    setup [:logged_in]

    test "redirects to show when data is valid", %{conn: conn} do
      conn = post conn, poll_path(conn, :create), poll: @create_attrs

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == poll_path(conn, :show, id)

      conn = get conn, poll_path(conn, :show, id)
      assert html_response(conn, 200) =~ "Show Poll"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, poll_path(conn, :create), poll: @invalid_attrs
      assert html_response(conn, 200) =~ "New Poll"
    end
  end

  describe "edit poll" do
    setup [:logged_in, :create_poll]

    test "renders form for editing chosen poll", %{conn: conn, poll: poll} do
      conn = get conn, poll_path(conn, :edit, poll)
      assert html_response(conn, 200) =~ "Edit Poll"
    end
  end

  describe "update poll" do
    setup [:logged_in, :create_poll]

    test "redirects when data is valid", %{conn: conn, poll: poll} do
      conn = put conn, poll_path(conn, :update, poll), poll: @update_attrs
      assert redirected_to(conn) == poll_path(conn, :show, poll)

      conn = get conn, poll_path(conn, :show, poll)
      assert html_response(conn, 200) =~ "some updated question"
    end

    test "renders errors when data is invalid", %{conn: conn, poll: poll} do
      conn = put conn, poll_path(conn, :update, poll), poll: @invalid_attrs
      assert html_response(conn, 200) =~ "Edit Poll"
    end
  end

  describe "delete poll" do
    setup [:logged_in, :create_poll]

    test "deletes chosen poll", %{conn: conn, poll: poll} do
      conn = delete conn, poll_path(conn, :delete, poll)
      assert redirected_to(conn) == poll_path(conn, :index)
      assert_error_sent 404, fn ->
        get conn, poll_path(conn, :show, poll)
      end
    end
  end

  defp create_poll(context) do
    user = context[:user] || fixture(:user)
    poll = fixture(:poll, participant: fixture(:participant, user: user))
    %{poll: poll, user: user}
  end

  defp logged_in(context) do
    user = context[:user] || fixture(:user)
    conn = build_conn()
    |> Plug.Test.init_test_session(user_id: user.id)
    %{conn: conn, user: user}
  end
end
