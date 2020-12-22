defmodule LiveViewStudioWeb.SalesDashboardLiveTest do
  use LiveViewStudioWeb.ConnCase, async: true

  import Phoenix.LiveViewTest

  test "refreshes when refresh button is clicked", %{conn: conn} do
    {:ok, view, _html} = live(conn, "/sales-dashboard")

    before_refresh = render(view)

    after_refresh =
      view
      |> element("button", "Refresh")
      |> render_click()

    refute after_refresh =~ before_refresh
  end

  test "refreshes automatically every tick", %{conn: conn} do
    {:ok, view, _html} = live(conn, "/sales-dashboard")

    before_refresh = render(view)

    send(view.pid, :tick)

    refute render(view) =~ before_refresh
  end
end
