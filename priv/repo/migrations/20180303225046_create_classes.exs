defmodule Tutoring.Repo.Migrations.CreateClasses do
  use Ecto.Migration

  def change do
    create table(:classes) do
      add :date, :date
      add :student_id, references(:students, on_delete: :nothing)

      timestamps()
    end

    create index(:classes, [:student_id])
  end
end
