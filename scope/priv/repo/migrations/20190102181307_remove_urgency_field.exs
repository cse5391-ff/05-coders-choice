defmodule Scope.Repo.Migrations.RemoveUrgencyField do
  use Ecto.Migration

  def change do
    def change do
      alter table(:messages) do
        remove :urgency
      end
    end
  end
end
