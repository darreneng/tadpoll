defmodule Tadpoll.AccountsTest do
  use Tadpoll.DataCase

  alias Tadpoll.Accounts

  import Tadpoll.Fixtures

  describe "users" do
    alias Tadpoll.Accounts.User

    @valid_attrs %{name: "some name", username: "some username", credential: %{email: "some@email.com"}}
    @update_attrs %{name: "some updated name", username: "some updated username"}
    @invalid_attrs %{name: nil, username: nil}

    test "list_users/0 returns all users" do
      user = fixture(:user)
      assert Accounts.list_users() == [user]
    end

    test "get_user!/1 returns the user with given id" do
      user = fixture(:user)
      assert Accounts.get_user!(user.id) == user
    end

    test "create_user/1 with valid data creates a user" do
      assert {:ok, %User{} = user} = Accounts.create_user(@valid_attrs)
      assert user.name == "some name"
      assert user.username == "some username"
    end

    test "create_user/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Accounts.create_user(@invalid_attrs)
    end

    test "update_user/2 with valid data updates the user" do
      user = fixture(:user)
      assert {:ok, user} = Accounts.update_user(user, @update_attrs)
      assert %User{} = user
      assert user.name == "some updated name"
      assert user.username == "some updated username"
    end

    test "update_user/2 with invalid data returns error changeset" do
      user = fixture(:user)
      assert {:error, %Ecto.Changeset{}} = Accounts.update_user(user, @invalid_attrs)
      assert user == Accounts.get_user!(user.id)
    end

    test "delete_user/1 deletes the user" do
      user = fixture(:user)
      assert {:ok, %User{}} = Accounts.delete_user(user)
      assert_raise Ecto.NoResultsError, fn -> Accounts.get_user!(user.id) end
    end

    test "change_user/1 returns a user changeset" do
      user = fixture(:user)
      assert %Ecto.Changeset{} = Accounts.change_user(user)
    end
  end

  describe "credentials" do
    alias Tadpoll.Accounts.Credential

    @update_attrs %{email: "some updated email"}
    @invalid_attrs %{email: nil}

    test "list_credentials/0 returns all credentials" do
      credential = fixture(:credential)
      assert Accounts.list_credentials() == [credential]
    end

    test "get_credential!/1 returns the credential with given id" do
      credential = fixture(:credential)
      assert Accounts.get_credential!(credential.id) == credential
    end

    test "update_credential/2 with valid data updates the credential" do
      credential = fixture(:credential)
      assert {:ok, credential} = Accounts.update_credential(credential, @update_attrs)
      assert %Credential{} = credential
      assert credential.email == "some updated email"
    end

    test "update_credential/2 with invalid data returns error changeset" do
      credential = fixture(:credential)
      assert {:error, %Ecto.Changeset{}} = Accounts.update_credential(credential, @invalid_attrs)
      assert credential == Accounts.get_credential!(credential.id)
    end

    test "delete_credential/1 deletes the credential" do
      credential = fixture(:credential)
      assert {:ok, %Credential{}} = Accounts.delete_credential(credential)
      assert_raise Ecto.NoResultsError, fn -> Accounts.get_credential!(credential.id) end
    end

    test "change_credential/1 returns a credential changeset" do
      credential = fixture(:credential)
      assert %Ecto.Changeset{} = Accounts.change_credential(credential)
    end
  end
end
