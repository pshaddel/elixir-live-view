defmodule LiveViewStudioWeb.SandboxLiveTest do
  use LiveViewStudioWeb.ConnCase, async: true

  import Phoenix.LiveViewTest

  test "initially renders calculator without a quote", %{conn: conn} do
    {:ok, view, _html} = live(conn, "/sandbox")

    assert has_element?(view, "#calculator", "You need 0 pounds")
    refute has_element?(view, "#quote")
  end

  test "changing the form calculates the weight", %{conn: conn} do
    {:ok, view, _html} = live(conn, "/sandbox")

    view
    |> form("#calculator", %{length: 1, width: 1, depth: 1})
    |> render_change()

    assert has_element?(view, "#calculator", "You need 7.3 pounds")
    refute has_element?(view, "#quote")
  end

  test "submitting the form shows the price quote", %{conn: conn} do
    {:ok, view, _html} = live(conn, "/sandbox")

    view
    |> form("#calculator", %{length: 1, width: 1, depth: 1})
    |> render_change()

    view
    |> form("#calculator")
    |> render_submit()

    assert has_element?(view, "#quote", "$10.95")
  end
end
