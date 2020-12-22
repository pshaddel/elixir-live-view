defmodule LiveViewStudioWeb.SearchLiveTest do
  use LiveViewStudioWeb.ConnCase, async: true

  import Phoenix.LiveViewTest

  test "renders", %{conn: conn} do
    {:ok, view, _html} = live(conn, "/search")

    assert render(view) =~ "Find a Store"
  end

  test "search shows matching stores", %{conn: conn} do
    {:ok, view, _html} = live(conn, "/search")

    view
    |> form("#zip-search", %{zip: 80204})
    |> render_submit()

    assert has_element?(view, "li", "Downtown Denver")
    assert has_element?(view, "li", "Midtown Denver")
    assert has_element?(view, "li", "Denver Stapleton")
    assert has_element?(view, "li", "Denver West")
  end

  test "search with no results shows error", %{conn: conn} do
    {:ok, view, _html} = live(conn, "/search")

    view
    |> form("#zip-search", %{zip: 00000})
    |> render_submit()

    assert render(view) =~ "No stores matching"
  end
end
