defmodule Scope.Repo.Migrations.CreateMessages do
  use Ecto.Migration

  def change do
    create table(:messages) do
      add :username, :string
      add :message, :string
      add :urgency, :string
      add :chatroom, :string

      timestamps()
    end

  end
end
