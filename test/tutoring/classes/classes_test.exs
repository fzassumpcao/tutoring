defmodule Tutoring.ClassesTest do
  use Tutoring.DataCase

  alias Tutoring.Classes

  describe "students" do
    alias Tutoring.Classes.Student

    @valid_attrs %{day: "some day", email: "some email", grade: 42, name: "some name", phone: "some phone", time: ~T[14:00:00.000000]}
    @update_attrs %{day: "some updated day", email: "some updated email", grade: 43, name: "some updated name", phone: "some updated phone", time: ~T[15:01:01.000000]}
    @invalid_attrs %{day: nil, email: nil, grade: nil, name: nil, phone: nil, time: nil}

    def student_fixture(attrs \\ %{}) do
      {:ok, student} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Classes.create_student()

      student
    end

    test "list_students/0 returns all students" do
      student = student_fixture()
      assert Classes.list_students() == [student]
    end

    test "get_student!/1 returns the student with given id" do
      student = student_fixture()
      assert Classes.get_student!(student.id) == student
    end

    test "create_student/1 with valid data creates a student" do
      assert {:ok, %Student{} = student} = Classes.create_student(@valid_attrs)
      assert student.day == "some day"
      assert student.email == "some email"
      assert student.grade == 42
      assert student.name == "some name"
      assert student.phone == "some phone"
      assert student.time == ~T[14:00:00.000000]
    end

    test "create_student/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Classes.create_student(@invalid_attrs)
    end

    test "update_student/2 with valid data updates the student" do
      student = student_fixture()
      assert {:ok, student} = Classes.update_student(student, @update_attrs)
      assert %Student{} = student
      assert student.day == "some updated day"
      assert student.email == "some updated email"
      assert student.grade == 43
      assert student.name == "some updated name"
      assert student.phone == "some updated phone"
      assert student.time == ~T[15:01:01.000000]
    end

    test "update_student/2 with invalid data returns error changeset" do
      student = student_fixture()
      assert {:error, %Ecto.Changeset{}} = Classes.update_student(student, @invalid_attrs)
      assert student == Classes.get_student!(student.id)
    end

    test "delete_student/1 deletes the student" do
      student = student_fixture()
      assert {:ok, %Student{}} = Classes.delete_student(student)
      assert_raise Ecto.NoResultsError, fn -> Classes.get_student!(student.id) end
    end

    test "change_student/1 returns a student changeset" do
      student = student_fixture()
      assert %Ecto.Changeset{} = Classes.change_student(student)
    end
  end
end
