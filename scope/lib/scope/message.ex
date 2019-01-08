defmodule Scope.Message do
  use Ecto.Schema
  import Ecto.Changeset
  import Ecto.Query, only: [from: 2]

  schema "messages" do
    field :chatroom, :string
    field :message, :string
    field :urgency, :string
    field :username, :string

    timestamps()
  end

  @doc false
  def changeset(message, attrs) do
    message
    |> cast(attrs, [:username, :message, :urgency, :chatroom])
    |> validate_required([:username, :message, :urgency, :chatroom])
  end

  def get_msgs(limit \\ 20) do
    Scope.Repo.all(Scope.Message, limit: limit)
  end

  def get_msgs_from(chatroom) do
    query = from u in Scope.Message,
              where: u.chatroom == ^chatroom

    Scope.Repo.all(query)
  end

  # get all channels
  def get_channels() do
    query = from u in Scope.Message,
              distinct: u.chatroom,
              select: u.chatroom

    Scope.Repo.all(query)
  end

  def get_channel(msgs) do
    from u in msgs,
     select: u.channel
  end

  def get_msgs_count() do
    query = from u in Scope.Message,
              group_by: u.chatroom,
              select: {u.chatroom, count(u.id)}
    Scope.Repo.all(query)
  end
end
