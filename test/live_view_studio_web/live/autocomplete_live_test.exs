defmodule LiveViewStudioWeb.AutocompleteLiveTest do
  use LiveViewStudioWeb.ConnCase, async: true

  import Phoenix.LiveViewTest

  test "renders", %{conn: conn} do
    {:ok, view, _html} = live(conn, "/autocomplete")

    assert render(view) =~ "Find a Store"
  end

  test "typing in city field suggests a city", %{conn: conn} do
    {:ok, view, _html} = live(conn, "/autocomplete")

    view
    |> form("#city-search", %{city: "D"})
    |> render_change()

    assert has_element?(view, "#matches option", "Denver, CO")
  end

  test "search by city shows matching stores", %{conn: conn} do
    {:ok, view, _html} = live(conn, "/autocomplete")

    view
    |> form("#city-search", %{city: "Denver, CO"})
    |> render_submit()

    assert has_element?(view, "li", "Downtown Denver")
    assert has_element?(view, "li", "Midtown Denver")
    assert has_element?(view, "li", "Denver Stapleton")
    assert has_element?(view, "li", "Denver West")
  end

  test "search by city with no results shows error", %{conn: conn} do
    {:ok, view, _html} = live(conn, "/autocomplete")

    view
    |> form("#city-search", %{city: ""})
    |> render_submit()

    assert render(view) =~ "No stores matching"
  end

  test "search by zip shows matching stores", %{conn: conn} do
    {:ok, view, _html} = live(conn, "/autocomplete")

    view
    |> form("#zip-search", %{zip: 80204})
    |> render_submit()

    assert has_element?(view, "li", "Downtown Denver")
    assert has_element?(view, "li", "Midtown Denver")
    assert has_element?(view, "li", "Denver Stapleton")
    assert has_element?(view, "li", "Denver West")
  end

  test "search by zip with no results shows error", %{conn: conn} do
    {:ok, view, _html} = live(conn, "/autocomplete")

    view
    |> form("#zip-search", %{zip: 00000})
    |> render_submit()

    assert render(view) =~ "No stores matching"
  end
end
