defmodule Scope.ChatFetcher do

  def get_msgs(channel) do
    Scope.Message.get_msgs_from(channel)
  end

  def save_msg(msg) do
    Scope.Message.changeset(%Scope.Message{}, msg) |> Scope.Repo.insert
  end
end
