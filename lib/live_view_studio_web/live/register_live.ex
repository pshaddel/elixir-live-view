defmodule LiveViewStudioWeb.RegisterLive do
  use LiveViewStudioWeb, :live_view

  alias LiveViewStudio.Accounts
  alias LiveViewStudio.Accounts.User

  def mount(_params, _session, socket) do
    {:ok, socket}
  end
end
