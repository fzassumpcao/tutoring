defmodule Tutoring.Repo.Migrations.CreateStudents do
  use Ecto.Migration

  def change do
    create table(:students) do
      add :name, :string
      add :grade, :integer
      add :phone, :string
      add :email, :string
      add :day, :string
      add :time, :time

      timestamps()
    end

  end
end
