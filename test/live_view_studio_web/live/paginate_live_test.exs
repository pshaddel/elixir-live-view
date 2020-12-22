defmodule LiveViewStudioWeb.PaginateLiveTest do
  use LiveViewStudioWeb.ConnCase, async: true

  import Phoenix.LiveViewTest

  test "initial render", %{conn: conn} do
    donation = create_donation("A")

    {:ok, view, _html} = live(conn, "/paginate")

    assert has_element?(view, donation_row(donation))
  end

  test "paginates using the options in the URL", %{conn: conn} do
    a = create_donation("Donation A")
    b = create_donation("Donation B")

    {:ok, view, _html} = live(conn, "/paginate?page=1&per_page=1")

    assert has_element?(view, donation_row(a))
    refute has_element?(view, donation_row(b))

    {:ok, view, _html} = live(conn, "/paginate?page=2&per_page=1")

    refute has_element?(view, donation_row(a))
    assert has_element?(view, donation_row(b))

    {:ok, view, _html} = live(conn, "/paginate?page=1&per_page=2")

    assert has_element?(view, donation_row(a))
    assert has_element?(view, donation_row(b))
  end

  test "clicking next, previous, and page links patch the URL", %{conn: conn} do
    _a = create_donation("Donation A")
    _b = create_donation("Donation B")
    _c = create_donation("Donation C")

    {:ok, view, _html} = live(conn, "/paginate?page=1&per_page=1")

    view
    |> element("a", "Next")
    |> render_click()

    assert_patched(view, "/paginate?page=2&per_page=1")

    view
    |> element("a", "Previous")
    |> render_click()

    assert_patched(view, "/paginate?page=1&per_page=1")

    view
    |> element("a", "2")
    |> render_click()

    assert_patched(view, "/paginate?page=2&per_page=1")
  end

  test "changing the per-page form patches the URL", %{conn: conn} do
    {:ok, view, _html} = live(conn, "/paginate?page=2")

    view
    |> form("#select-per-page", %{"per-page": 10})
    |> render_change()

    assert_patched(view, "/paginate?page=2&per_page=10")
  end

  defp donation_row(donation), do: "#donation-#{donation.id}"

  defp create_donation(item) do
    {:ok, donation} =
      LiveViewStudio.Donations.create_donation(%{
        item: item,
        # these are irrelevant for tests:
        emoji: "🥝",
        quantity: 1,
        days_until_expires: 1
      })

    donation
  end
end
