defmodule LiveViewStudioWeb.KeyEventsLiveTest do
  use LiveViewStudioWeb.ConnCase, async: true

  import Phoenix.LiveViewTest

  test "right/left arrow keys show next/previous image", %{conn: conn} do
    {:ok, view, _html} = live(conn, "/key-events")

    assert has_element?(view, "img[src*=0.jpg]")

    view
    |> element("#key-events")
    |> render_keyup(%{"key" => "ArrowRight"})

    assert has_element?(view, "img[src*=1.jpg]")

    view
    |> element("#key-events")
    |> render_keyup(%{"key" => "ArrowLeft"})

    assert has_element?(view, "img[src*=0.jpg]")
  end

  test "pressing 'k' key plays and pauses", %{conn: conn} do
    {:ok, view, _html} = live(conn, "/key-events")

    assert render(view) =~ "Paused"

    view
    |> element("#key-events")
    |> render_keyup(%{"key" => "k"})

    assert render(view) =~ "Playing"

    view
    |> element("#key-events")
    |> render_keyup(%{"key" => "k"})

    assert render(view) =~ "Paused"
  end

  test "pressing Enter in input field changes current", %{conn: conn} do
    {:ok, view, _html} = live(conn, "/key-events")

    assert has_element?(view, "img[src*=0.jpg]")

    view
    |> element("input[type=number]")
    |> render_keyup(%{"key" => "Enter", "value" => "2"})

    assert has_element?(view, "img[src*=2.jpg]")
  end

  test "shows next image every tick", %{conn: conn} do
    {:ok, view, _html} = live(conn, "/key-events")

    assert has_element?(view, "img[src*=0.jpg]")

    send(view.pid, :tick)

    assert has_element?(view, "img[src*=1.jpg]")
  end
end
