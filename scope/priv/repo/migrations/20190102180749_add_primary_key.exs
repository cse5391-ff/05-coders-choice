defmodule Scope.Repo.Migrations.AddPrimaryKey do
  use Ecto.Migration

  def change do
    alter table(:messages) do
      add(:id, :integer, primary_key: true)
    end
  end
end
