defmodule RandomUserMatcher.Application do

  use Application

  def start(_type, _args) do

    children = [
      { Supervisor, strategy: :one_for_one, name: RandomUserMatcher.Supervisor }
    ]

    Supervisor.start_link(children, strategy: :one_for_one)

  end

end
