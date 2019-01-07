defmodule Scope.ChatFetcher do

  def get_msgs(channel) do
    Scope.Message.get_msgs_from(channel)
  end

  def save_msg(msg) do
    Scope.Message.changeset(%Scope.Message{}, msg) |> Scope.Repo.insert
  end

  def get_channels() do
    Scope.Message.get_channels()
  end

  def get_msgs_count() do
    # return number of msgs from each chat
    Scope.Message.get_msgs_count()
  end

end
