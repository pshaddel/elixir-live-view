defmodule LiveViewStudioWeb.LicenseLiveTest do
  use LiveViewStudioWeb.ConnCase, async: true

  import Phoenix.LiveViewTest

  test "updating number of seats changes seats and amount", %{conn: conn} do
    {:ok, view, _html} = live(conn, "/license")

    assert has_element?(view, "#seats", "3")
    assert has_element?(view, "#amount", "$60.00")

    view
    |> form("#update-seats", %{seats: 4})
    |> render_change()

    assert has_element?(view, "#seats", "4")
    assert has_element?(view, "#amount", "$80.00")
  end
end
