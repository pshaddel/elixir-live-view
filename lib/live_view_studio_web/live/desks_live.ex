defmodule LiveViewStudioWeb.DesksLive do
  use LiveViewStudioWeb, :live_view

  alias LiveViewStudio.Desks
  alias LiveViewStudio.Desks.Desk

  def mount(_params, _session, socket) do
    if connected?(socket), do: Desks.subscribe()

    desks = Desks.list_desks()
    changeset = Desks.change_desk(%Desk{})

    socket =
      assign(socket,
        desks: desks,
        changeset: changeset
      )

    {:ok, socket, temporary_assigns: [desks: []]}
  end

  def handle_event("save", %{"desk" => params}, socket) do
    case Desks.create_desk(%Desk{}, params) do
      {:ok, _desk} ->
        changeset = Desks.change_desk(%Desk{})
        {:noreply, assign(socket, changeset: changeset)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end

  def handle_event("validate", %{"desk" => params}, socket) do
    changeset =
      %Desk{}
      |> Desks.change_desk(params)
      |> Map.put(:action, :insert)

    {:noreply, assign(socket, changeset: changeset)}
  end

  def handle_info({:desk_created, desk}, socket) do
    {:noreply, update(socket, :desks, fn desks -> [desk | desks] end)}
  end
end
