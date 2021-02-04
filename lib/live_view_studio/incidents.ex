defmodule LiveViewStudio.Incidents do
  @moduledoc """
  The Incidents context.
  """

  import Ecto.Query, warn: false
  alias LiveViewStudio.Repo

  alias LiveViewStudio.Incidents.Incident

  @doc """
  Returns the list of incidents.

  ## Examples

      iex> list_incidents()
      [%Incident{}, ...]

  """
  def list_incidents do
    Repo.all(from i in Incident, order_by: [desc: i.id])
  end

  @doc """
  Gets a single incident.

  Raises `Ecto.NoResultsError` if the Incident does not exist.

  ## Examples

      iex> get_incident!(123)
      %Incident{}

      iex> get_incident!(456)
      ** (Ecto.NoResultsError)

  """
  def get_incident!(id), do: Repo.get!(Incident, id)

  @doc """
  Creates a incident.

  ## Examples

      iex> create_incident(%{field: value})
      {:ok, %Incident{}}

      iex> create_incident(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_incident(attrs \\ %{}) do
    %Incident{}
    |> Incident.changeset(attrs)
    |> Repo.insert()
    |> broadcast(:incident_created)
  end

  @doc """
  Creates a random incident.

  ## Examples

      iex> create_random_incident()
      {:ok, %Incident{}}

  """
  def create_random_incident do
    descriptions = [
      "🦊 Fox in the henhouse",
      "🏢 Stuck in an elevator",
      "🚦 Traffic lights out",
      "🏎 Reckless driving",
      "🐻 Bear in the trash",
      "🤡 Disturbing the peace",
      "🔥 BBQ fire",
      "🙀 #{Faker.Cat.name()} stuck in a tree",
      "🐶 #{Faker.Dog.PtBr.name()} on the loose"
    ]

    {lat, lng} = LiveViewStudio.Geo.randomDenverLatLng()

    {:ok, _incident} =
      create_incident(%{
        lat: lat,
        lng: lng,
        description: Enum.random(descriptions)
      })
  end

  @doc """
  Updates a incident.

  ## Examples

      iex> update_incident(incident, %{field: new_value})
      {:ok, %Incident{}}

      iex> update_incident(incident, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_incident(%Incident{} = incident, attrs) do
    incident
    |> Incident.changeset(attrs)
    |> Repo.update()
    |> broadcast(:incident_updated)
  end

  @doc """
  Deletes a incident.

  ## Examples

      iex> delete_incident(incident)
      {:ok, %Incident{}}

      iex> delete_incident(incident)
      {:error, %Ecto.Changeset{}}

  """
  def delete_incident(%Incident{} = incident) do
    Repo.delete(incident)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking incident changes.

  ## Examples

      iex> change_incident(incident)
      %Ecto.Changeset{data: %Incident{}}

  """
  def change_incident(%Incident{} = incident, attrs \\ %{}) do
    Incident.changeset(incident, attrs)
  end

  def subscribe do
    Phoenix.PubSub.subscribe(LiveViewStudio.PubSub, "incidents")
  end

  defp broadcast({:ok, incident}, event) do
    Phoenix.PubSub.broadcast(
      LiveViewStudio.PubSub,
      "incidents",
      {event, incident}
    )

    {:ok, incident}
  end

  defp broadcast({:error, _changeset} = error, _event), do: error
end
