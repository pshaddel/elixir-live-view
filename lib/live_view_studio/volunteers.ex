defmodule LiveViewStudio.Volunteers do
  @moduledoc """
  The Volunteers context.
  """

  import Ecto.Query, warn: false
  alias LiveViewStudio.Repo

  alias LiveViewStudio.Volunteers.Volunteer

  def subscribe() do
    Phoenix.PubSub.subscribe(LiveViewStudio.PubSub, "volunteers")
  end

  @doc """
  Returns the list of volunteers.

  ## Examples

      iex> list_volunteers()
      [%Volunteer{}, ...]

  """
  def list_volunteers do
    Repo.all(from v in Volunteer, order_by: [desc: v.id])
  end

  @doc """
  Gets a single volunteer.

  Raises `Ecto.NoResultsError` if the Volunteer does not exist.

  ## Examples

      iex> get_volunteer!(123)
      %Volunteer{}

      iex> get_volunteer!(456)
      ** (Ecto.NoResultsError)

  """
  def get_volunteer!(id), do: Repo.get!(Volunteer, id)

  @doc """
  Creates a volunteer.

  ## Examples

      iex> create_volunteer(%{field: value})
      {:ok, %Volunteer{}}

      iex> create_volunteer(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_volunteer(attrs \\ %{}) do
    %Volunteer{}
    |> Volunteer.changeset(attrs)
    |> Repo.insert()
    |> broadcast(:volunteer_created)
  end

  @doc """
  Updates a volunteer.

  ## Examples

      iex> update_volunteer(volunteer, %{field: new_value})
      {:ok, %Volunteer{}}

      iex> update_volunteer(volunteer, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_volunteer(%Volunteer{} = volunteer, attrs) do
    volunteer
    |> Volunteer.changeset(attrs)
    |> Repo.update()
    |> broadcast(:update_volunteer)
  end

  @doc """
  Deletes a volunteer.

  ## Examples

      iex> delete_volunteer(volunteer)
      {:ok, %Volunteer{}}

      iex> delete_volunteer(volunteer)
      {:error, %Ecto.Changeset{}}

  """
  def delete_volunteer(%Volunteer{} = volunteer) do
    Repo.delete(volunteer)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking volunteer changes.

  ## Examples

      iex> change_volunteer(volunteer)
      %Ecto.Changeset{data: %Volunteer{}}

  """
  def change_volunteer(%Volunteer{} = volunteer, attrs \\ %{}) do
    Volunteer.changeset(volunteer, attrs)
  end

  defp broadcast({:ok, volunteer}, event) do
    Phoenix.PubSub.broadcast!(LiveViewStudio.PubSub, "volunteers", {event, volunteer})
    {:ok, volunteer}
  end

  defp broadcast({:error, _reason}, event) do
    {:error, event}
  end
end
