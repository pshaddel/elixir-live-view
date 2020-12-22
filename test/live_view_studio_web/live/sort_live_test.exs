defmodule LiveViewStudioWeb.SortLiveTest do
  use LiveViewStudioWeb.ConnCase, async: true

  import Phoenix.LiveViewTest

  test "initially renders donations ordered by id ascending", %{conn: conn} do
    a = create_donation("A")
    b = create_donation("B")
    c = create_donation("C")

    {:ok, view, _html} = live(conn, "/sort")

    assert render(view) =~ donations_in_order(a, b, c)
  end

  test "sorts using the options in the URL", %{conn: conn} do
    a = create_donation("A")
    b = create_donation("B")
    c = create_donation("C")

    {:ok, view, _html} = live(conn, sort_path("item", "desc"))

    assert render(view) =~ donations_in_order(c, b, a)
  end

  test "clicking sorting links patches the URL", %{conn: conn} do
    {:ok, view, _html} = live(conn, "/sort")

    view
    |> element("a", "Item")
    |> render_click()

    assert_patched(view, sort_path("item", "desc"))

    view
    |> element("a", "Quantity")
    |> render_click()

    assert_patched(view, sort_path("quantity", "asc"))

    view
    |> element("a", "Days Until Expires")
    |> render_click()

    assert_patched(view, sort_path("days_until_expires", "desc"))
  end

  defp sort_path(sort_by, sort_order) do
    "/sort?" <> "sort_by=#{sort_by}&sort_order=#{sort_order}&page=1&per_page=5"
  end

  defp donations_in_order(first, second, third) do
    ~r/#{first.item}.*#{second.item}.*#{third.item}/s
  end

  defp create_donation(item) do
    {:ok, donation} =
      LiveViewStudio.Donations.create_donation(%{
        item: item,
        emoji: "✅",
        quantity: 1,
        days_until_expires: 1
      })

    donation
  end
end
