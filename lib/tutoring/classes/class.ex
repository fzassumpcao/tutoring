defmodule Tutoring.Classes.Class do
  use Ecto.Schema
  import Ecto.Changeset
  alias Tutoring.Classes.Class


  schema "classes" do
    field :date, :date
    belongs_to :student, Tutoring.Classes.Student

    timestamps()
  end

  @doc false
  def changeset(%Class{} = class, attrs) do
    class
    |> cast(attrs, [:date, :student_id])
    |> validate_required([:date, :student_id])
  end
end
