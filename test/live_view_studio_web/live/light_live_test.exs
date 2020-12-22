defmodule LiveViewStudioWeb.LightLiveTest do
  use LiveViewStudioWeb.ConnCase, async: true

  import Phoenix.LiveViewTest

  test "initial render", %{conn: conn} do
    {:ok, view, html} = live(conn, "/light")

    assert html =~ "Porch Light"
    assert render(view) =~ "Porch Light"
  end

  test "light controls", %{conn: conn} do
    {:ok, view, _html} = live(conn, "/light")

    assert render(view) =~ "10%"
    assert view |> element("button", "Up") |> render_click() =~ "20%"
    assert view |> element("button", "Down") |> render_click() =~ "10%"
    assert view |> element("button", "On") |> render_click() =~ "100%"
    assert view |> element("button", "Off") |> render_click() =~ "0%"
    refute render(view) =~ "100%"
  end
end
