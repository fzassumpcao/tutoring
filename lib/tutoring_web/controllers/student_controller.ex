defmodule TutoringWeb.StudentController do
  use TutoringWeb, :controller

  alias Tutoring.Classes
  alias Tutoring.Classes.Student

  def index(conn, _params) do
    students = Classes.list_students()
    render(conn, "index.html", students: students)
  end

  def new(conn, _params) do
    changeset = Classes.change_student(%Student{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"student" => student_params}) do
    case Classes.create_student(student_params) do
      {:ok, student} ->
        conn
        |> put_flash(:info, "Student created successfully.")
        |> redirect(to: student_path(conn, :show, student))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    student = Classes.get_student!(id)
    render(conn, "show.html", student: student)
  end

  def edit(conn, %{"id" => id}) do
    student = Classes.get_student!(id)
    changeset = Classes.change_student(student)
    render(conn, "edit.html", student: student, changeset: changeset)
  end

  def update(conn, %{"id" => id, "student" => student_params}) do
    student = Classes.get_student!(id)

    case Classes.update_student(student, student_params) do
      {:ok, student} ->
        conn
        |> put_flash(:info, "Student updated successfully.")
        |> redirect(to: student_path(conn, :show, student))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", student: student, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    student = Classes.get_student!(id)
    {:ok, _student} = Classes.delete_student(student)

    conn
    |> put_flash(:info, "Student deleted successfully.")
    |> redirect(to: student_path(conn, :index))
  end
end
