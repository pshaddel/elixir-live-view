defmodule LiveViewStudioWeb.FilterLiveTest do
  use LiveViewStudioWeb.ConnCase, async: true

  import Phoenix.LiveViewTest

  test "filters boats by type and price", %{conn: conn} do
    fishing_1 = create_boat(model: "A", price: "$", type: "fishing")
    fishing_2 = create_boat(model: "B", price: "$$", type: "fishing")
    sporting_2 = create_boat(model: "C", price: "$$", type: "sporting")

    {:ok, view, _html} = live(conn, "/filter")

    assert has_element?(view, boat_card(fishing_1))
    assert has_element?(view, boat_card(fishing_2))
    assert has_element?(view, boat_card(sporting_2))

    view
    |> form("#change-filter", %{type: "fishing", prices: ["$"]})
    |> render_change()

    assert has_element?(view, boat_card(fishing_1))
    refute has_element?(view, boat_card(fishing_2))
    refute has_element?(view, boat_card(sporting_2))
  end

  test "initially renders boats of all types and prices", %{conn: conn} do
    fishing = create_boat(model: "A", price: "$", type: "fishing")
    sporting = create_boat(model: "B", price: "$$", type: "sporting")

    {:ok, view, _html} = live(conn, "/filter")

    assert has_element?(view, boat_card(fishing))
    assert has_element?(view, boat_card(sporting))
  end

  defp boat_card(boat), do: "#boat-#{boat.id}"

  def create_boat(attrs) do
    {:ok, boat} =
      attrs
      |> Enum.into(%{image: "image"})
      |> LiveViewStudio.Boats.create_boat()

    boat
  end
end
