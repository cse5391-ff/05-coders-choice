defmodule Scope.ChannelListFetcher do

  def get_channels() do
    Scope.Message.get_channels()
  end
end
