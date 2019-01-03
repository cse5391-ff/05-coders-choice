defmodule Scope.Message do
  use Ecto.Schema
  import Ecto.Changeset


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
end
