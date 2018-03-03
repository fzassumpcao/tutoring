defmodule TutoringWeb.ClassControllerTest do
  use TutoringWeb.ConnCase

  alias Tutoring.Classes

  @create_attrs %{date: ~D[2010-04-17]}
  @update_attrs %{date: ~D[2011-05-18]}
  @invalid_attrs %{date: nil}

  def fixture(:class) do
    {:ok, class} = Classes.create_class(@create_attrs)
    class
  end

  describe "index" do
    test "lists all classes", %{conn: conn} do
      conn = get conn, class_path(conn, :index)
      assert html_response(conn, 200) =~ "Listing Classes"
    end
  end

  describe "new class" do
    test "renders form", %{conn: conn} do
      conn = get conn, class_path(conn, :new)
      assert html_response(conn, 200) =~ "New Class"
    end
  end

  describe "create class" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post conn, class_path(conn, :create), class: @create_attrs

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == class_path(conn, :show, id)

      conn = get conn, class_path(conn, :show, id)
      assert html_response(conn, 200) =~ "Show Class"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, class_path(conn, :create), class: @invalid_attrs
      assert html_response(conn, 200) =~ "New Class"
    end
  end

  describe "edit class" do
    setup [:create_class]

    test "renders form for editing chosen class", %{conn: conn, class: class} do
      conn = get conn, class_path(conn, :edit, class)
      assert html_response(conn, 200) =~ "Edit Class"
    end
  end

  describe "update class" do
    setup [:create_class]

    test "redirects when data is valid", %{conn: conn, class: class} do
      conn = put conn, class_path(conn, :update, class), class: @update_attrs
      assert redirected_to(conn) == class_path(conn, :show, class)

      conn = get conn, class_path(conn, :show, class)
      assert html_response(conn, 200)
    end

    test "renders errors when data is invalid", %{conn: conn, class: class} do
      conn = put conn, class_path(conn, :update, class), class: @invalid_attrs
      assert html_response(conn, 200) =~ "Edit Class"
    end
  end

  describe "delete class" do
    setup [:create_class]

    test "deletes chosen class", %{conn: conn, class: class} do
      conn = delete conn, class_path(conn, :delete, class)
      assert redirected_to(conn) == class_path(conn, :index)
      assert_error_sent 404, fn ->
        get conn, class_path(conn, :show, class)
      end
    end
  end

  defp create_class(_) do
    class = fixture(:class)
    {:ok, class: class}
  end
end
