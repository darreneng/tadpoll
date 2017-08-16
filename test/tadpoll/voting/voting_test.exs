defmodule Tadpoll.VotingTest do
  use Tadpoll.DataCase

  alias Tadpoll.Voting

  import Tadpoll.Fixtures

  describe "polls" do
    alias Tadpoll.Voting.Poll

    @valid_attrs %{question: "some question"}
    @update_attrs %{question: "some updated question"}
    @invalid_attrs %{question: nil}

    test "list_polls/0 returns all polls" do
      poll = fixture(:poll)
      assert Voting.list_polls() == [poll]
    end

    test "get_poll!/1 returns the poll with given id" do
      poll = fixture(:poll)
      assert Voting.get_poll!(poll.id) == poll
    end

    test "create_poll/2 with valid data creates a poll" do
      participant = fixture(:participant)
      assert {:ok, %Poll{} = poll} = Voting.create_poll(participant, @valid_attrs)
      assert poll.question == "some question"
    end

    test "create_poll/2 with invalid data returns error changeset" do
      participant = fixture(:participant)
      assert {:error, %Ecto.Changeset{}} = Voting.create_poll(participant, @invalid_attrs)
    end

    test "update_poll/2 with valid data updates the poll" do
      poll = fixture(:poll)
      assert {:ok, poll} = Voting.update_poll(poll, @update_attrs)
      assert %Poll{} = poll
      assert poll.question == "some updated question"
    end

    test "update_poll/2 with invalid data returns error changeset" do
      poll = fixture(:poll)
      assert {:error, %Ecto.Changeset{}} = Voting.update_poll(poll, @invalid_attrs)
      assert poll == Voting.get_poll!(poll.id)
    end

    test "delete_poll/1 deletes the poll" do
      poll = fixture(:poll)
      assert {:ok, %Poll{}} = Voting.delete_poll(poll)
      assert_raise Ecto.NoResultsError, fn -> Voting.get_poll!(poll.id) end
    end

    test "change_poll/1 returns a poll changeset" do
      poll = fixture(:poll)
      assert %Ecto.Changeset{} = Voting.change_poll(poll)
    end
  end

  describe "participants" do
    alias Tadpoll.Voting.Participant

    @valid_attrs %{}
    @update_attrs %{}

    test "list_participants/0 returns all participants" do
      participant = fixture(:participant)
      assert Voting.list_participants() == [participant]
    end

    test "get_participant!/1 returns the participant with given id" do
      participant = fixture(:participant)
      assert Voting.get_participant!(participant.id) == participant
    end

    test "update_participant/2 with valid data updates the participant" do
      participant = fixture(:participant)
      assert {:ok, participant} = Voting.update_participant(participant, @update_attrs)
      assert %Participant{} = participant
    end

    test "delete_participant/1 deletes the participant" do
      participant = fixture(:participant)
      assert {:ok, %Participant{}} = Voting.delete_participant(participant)
      assert_raise Ecto.NoResultsError, fn -> Voting.get_participant!(participant.id) end
    end

    test "change_participant/1 returns a participant changeset" do
      participant = fixture(:participant)
      assert %Ecto.Changeset{} = Voting.change_participant(participant)
    end
  end

  describe "votes" do
    alias Tadpoll.Voting.Vote

    @valid_attrs %{selection: 42}
    @update_attrs %{selection: 43}
    @invalid_attrs %{selection: nil}

    test "list_votes/0 returns all votes" do
      vote = fixture(:vote)
      assert Voting.list_votes() == [vote]
    end

    test "get_vote!/1 returns the vote with given id" do
      vote = fixture(:vote)
      assert Voting.get_vote!(vote.id) == vote
    end

    test "create_vote/3 with valid data creates a vote" do
      poll = fixture(:poll)
      participant = poll.participant
      assert {:ok, %Vote{} = vote} = Voting.create_vote(participant, poll, @valid_attrs)
      assert vote.selection == 42
    end

    test "create_vote/3 with invalid data returns error changeset" do
      poll = fixture(:poll)
      participant = poll.participant
      assert {:error, %Ecto.Changeset{}} = Voting.create_vote(participant, poll, @invalid_attrs)
    end

    test "create_vote/3 allows only one vote per participant and poll pair" do
      poll = fixture(:poll)
      participant = poll.participant
      assert {:ok, %Vote{}} = Voting.create_vote(participant, poll, @valid_attrs)
      assert {:error, %Ecto.Changeset{}} = Voting.create_vote(participant, poll, @valid_attrs)
    end

    test "update_vote/2 with valid data updates the vote" do
      vote = fixture(:vote)
      assert {:ok, vote} = Voting.update_vote(vote, @update_attrs)
      assert %Vote{} = vote
      assert vote.selection == 43
    end

    test "update_vote/2 with invalid data returns error changeset" do
      vote = fixture(:vote)
      assert {:error, %Ecto.Changeset{}} = Voting.update_vote(vote, @invalid_attrs)
      assert vote == Voting.get_vote!(vote.id)
    end

    test "delete_vote/1 deletes the vote" do
      vote = fixture(:vote)
      assert {:ok, %Vote{}} = Voting.delete_vote(vote)
      assert_raise Ecto.NoResultsError, fn -> Voting.get_vote!(vote.id) end
    end

    test "change_vote/1 returns a vote changeset" do
      vote = fixture(:vote)
      assert %Ecto.Changeset{} = Voting.change_vote(vote)
    end
  end
end
