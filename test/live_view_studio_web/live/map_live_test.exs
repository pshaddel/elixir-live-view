defmodule LiveViewStudioWeb.MapLiveTest do
  use LiveViewStudioWeb.ConnCase, async: true

  import Phoenix.LiveViewTest

  alias LiveViewStudio.Incidents

  test "initially renders map and list of incidents", %{conn: conn} do
    incident = create_incident("Help")

    {:ok, view, _html} = live(conn, "/map")

    assert has_element?(view, "#map")
    assert has_element?(view, ".sidebar", incident.description)
  end

  test "clicking an incident selects it", %{conn: conn} do
    incident = create_incident("Help")

    {:ok, view, _html} = live(conn, "/map")

    view
    |> element(clickable_incident(incident))
    |> render_click()

    assert has_element?(view, ".incident.selected", incident.description)
  end

  test "broadcasted new incident is added and selected", %{conn: conn} do
    {:ok, view, _html} = live(conn, "/map")

    incident = create_incident("Help")

    assert has_element?(view, clickable_incident(incident))
    assert has_element?(view, ".incident.selected", incident.description)
  end

  defp clickable_incident(incident) do
    "div[phx-value-id=#{incident.id}]"
  end

  defp create_incident(description) do
    {lat, lng} = LiveViewStudio.Geo.randomDenverLatLng()

    {:ok, incident} =
      Incidents.create_incident(%{
        description: description,
        lat: lat,
        lng: lng
      })

    incident
  end
end
