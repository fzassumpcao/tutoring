defmodule TutoringWeb.ClassController do
  use TutoringWeb, :controller

  alias Tutoring.Classes
  alias Tutoring.Classes.Class

  def index(conn, _params) do
    classes = Classes.list_classes()
    render(conn, "index.html", classes: classes)
  end

  def new(conn, _params) do
    students = Classes.list_students()
    changeset = Classes.change_class(%Class{})
    render(conn, "new.html", changeset: changeset, students: students)
  end

  def create(conn, %{"class" => class_params}) do
    case Classes.create_class(class_params) do
      {:ok, class} ->
        conn
        |> put_flash(:info, "Class created successfully.")
        |> redirect(to: class_path(conn, :show, class))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    class = Classes.get_class!(id)
    render(conn, "show.html", class: class)
  end

  def edit(conn, %{"id" => id}) do
    students = Classes.list_students()
    class = Classes.get_class!(id)
    changeset = Classes.change_class(class)
    render(conn, "edit.html", class: class, changeset: changeset, students: students)
  end

  def update(conn, %{"id" => id, "class" => class_params}) do
    class = Classes.get_class!(id)

    case Classes.update_class(class, class_params) do
      {:ok, class} ->
        conn
        |> put_flash(:info, "Class updated successfully.")
        |> redirect(to: class_path(conn, :show, class))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", class: class, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    class = Classes.get_class!(id)
    {:ok, _class} = Classes.delete_class(class)

    conn
    |> put_flash(:info, "Class deleted successfully.")
    |> redirect(to: class_path(conn, :index))
  end
end
