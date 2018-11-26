defmodule Scope.Repo.Migrations.AlterMessages do
  use Ecto.Migration

  def change do
      alter table(:messages) do
        add :tacton, :string
      end
  end
end
