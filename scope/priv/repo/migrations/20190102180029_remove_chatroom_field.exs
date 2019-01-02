defmodule Scope.Repo.Migrations.RemoveChatroomField do
  use Ecto.Migration

  def change do
    alter table(:messages) do
      remove :chatroom
    end
  end
end
