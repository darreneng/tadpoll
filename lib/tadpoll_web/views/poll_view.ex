defmodule TadpollWeb.PollView do
  use TadpollWeb, :view

  alias Tadpoll.Voting

  def participant_name(%Voting.Poll{participant: participant}) do
    participant.user.name
  end
end
