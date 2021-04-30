defmodule LiveViewStudioWeb.VolunteersLive do
  use LiveViewStudioWeb, :live_view

  alias LiveViewStudio.Volunteers
  alias LiveViewStudio.Volunteers.Volunteer

  def mount(_params, _session, socket) do
    if(connected?(socket)) do
      Volunteers.subscribe()
    end

    volunteers = Volunteers.list_volunteers()

    changeset = Volunteers.change_volunteer(%Volunteer{})

    socket =
      assign(socket,
        volunteers: volunteers,
        changeset: changeset
      )

    {:ok, socket, temporary_assigns: [volunteers: []]}
  end

  def handle_event("save", %{"volunteer" => params}, socket) do
    case Volunteers.create_volunteer(params) do
      {:ok, volunteer} ->
        changeset = Volunteers.change_volunteer(%Volunteer{})

        socket = assign(socket, changeset: changeset)

        {:noreply, socket}

      {:error, %Ecto.Changeset{} = changeset} ->
        socket = assign(socket, changeset: changeset)
        {:noreply, socket}
    end
  end

  def handle_event("validate", %{"volunteer" => params}, socket) do
    changeset =
      %Volunteer{}
      |> Volunteers.change_volunteer(params)
      |> Map.put(:action, :insert)

    socket =
      assign(socket,
        changeset: changeset
      )

    {:noreply, socket}
  end

  def handle_event("toggle-status", %{"id" => id}, socket) do
    volunteer = Volunteers.get_volunteer!(id)

    {:ok, _volunteer} =
      Volunteers.update_volunteer(
        volunteer,
        %{checked_out: !volunteer.checked_out}
      )

    {:noreply, socket}
  end

  def handle_info({:volunteer_created, volunteer}, socket) do
    socket =
      update(
        socket,
        :volunteers,
        fn volunteers -> [volunteer | volunteers] end
      )

    {:noreply, socket}
  end

  def handle_info({:volunteer_updated, volunteer}, socket) do
    socket =
      update(
        socket,
        :volunteers,
        fn volunteers -> [volunteer | volunteers] end
      )

    {:noreply, socket}
  end
end
