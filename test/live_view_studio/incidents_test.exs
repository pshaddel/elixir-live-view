defmodule LiveViewStudio.IncidentsTest do
  use LiveViewStudio.DataCase

  alias LiveViewStudio.Incidents

  describe "incidents" do
    alias LiveViewStudio.Incidents.Incident

    @valid_attrs %{description: "some description", lat: 120.5, lng: 120.5}
    @update_attrs %{description: "some updated description", lat: 456.7, lng: 456.7}
    @invalid_attrs %{description: nil, lat: nil, lng: nil}

    def incident_fixture(attrs \\ %{}) do
      {:ok, incident} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Incidents.create_incident()

      incident
    end

    test "list_incidents/0 returns all incidents" do
      incident = incident_fixture()
      assert Incidents.list_incidents() == [incident]
    end

    test "get_incident!/1 returns the incident with given id" do
      incident = incident_fixture()
      assert Incidents.get_incident!(incident.id) == incident
    end

    test "create_incident/1 with valid data creates a incident" do
      assert {:ok, %Incident{} = incident} = Incidents.create_incident(@valid_attrs)
      assert incident.description == "some description"
      assert incident.lat == 120.5
      assert incident.lng == 120.5
    end

    test "create_incident/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Incidents.create_incident(@invalid_attrs)
    end

    test "update_incident/2 with valid data updates the incident" do
      incident = incident_fixture()
      assert {:ok, %Incident{} = incident} = Incidents.update_incident(incident, @update_attrs)
      assert incident.description == "some updated description"
      assert incident.lat == 456.7
      assert incident.lng == 456.7
    end

    test "update_incident/2 with invalid data returns error changeset" do
      incident = incident_fixture()
      assert {:error, %Ecto.Changeset{}} = Incidents.update_incident(incident, @invalid_attrs)
      assert incident == Incidents.get_incident!(incident.id)
    end

    test "delete_incident/1 deletes the incident" do
      incident = incident_fixture()
      assert {:ok, %Incident{}} = Incidents.delete_incident(incident)
      assert_raise Ecto.NoResultsError, fn -> Incidents.get_incident!(incident.id) end
    end

    test "change_incident/1 returns a incident changeset" do
      incident = incident_fixture()
      assert %Ecto.Changeset{} = Incidents.change_incident(incident)
    end
  end
end
