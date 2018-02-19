defmodule Tutoring.Classes.Student do
  use Ecto.Schema
  import Ecto.Changeset
  alias Tutoring.Classes.Student


  schema "students" do
    field :day, :string
    field :email, :string
    field :grade, :integer
    field :name, :string
    field :phone, :string
    field :time, :time

    timestamps()
  end

  @doc false
  def changeset(%Student{} = student, attrs) do
    student
    |> cast(attrs, [:name, :grade, :phone, :email, :day, :time])
    |> validate_required([:name, :grade, :day, :time])
    |> validate_format(:email, ~r/^[A-Z0-9._%-]+@[A-Z0-9.-]+\.[A-Z]{2,4}$/)
    |> validate_inclusion(:grade, 7..8)
    |> validate_format(:phone, ~r/^\(?([0-9]{3})\)?[-.●]?([0-9]{3})[-.●]?([0-9]{4})$/)
    |> validate_inclusion(:day, ["Monday", "Tuesday", "Wednesday", "Thrusday", "Friday"])
  end
end
