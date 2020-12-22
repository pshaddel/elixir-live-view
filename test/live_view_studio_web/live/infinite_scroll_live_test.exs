defmodule LiveViewStudioWeb.InfiniteScrollLiveTest do
  use LiveViewStudioWeb.ConnCase, async: true

  import Phoenix.LiveViewTest

  test "renders more orders when user scrolls to bottom", %{conn: conn} do
    create_orders()

    {:ok, view, _html} = live(conn, "/infinite-scroll")

    assert render(view) |> number_of_orders() == 10

    view
    |> element("#footer")
    |> render_hook("load-more", %{})

    assert render(view) |> number_of_orders() == 11
  end

  defp number_of_orders(html) do
    html |> :binary.matches("Test Pizza") |> length()
  end

  defp create_orders do
    for i <- 1..11 do
      {:ok, _order} =
        LiveViewStudio.PizzaOrders.create_pizza_order(%{
          username: "Test User #{i}",
          pizza: "Test Pizza #{i}"
        })
    end
  end
end
