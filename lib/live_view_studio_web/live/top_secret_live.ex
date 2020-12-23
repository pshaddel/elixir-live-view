defmodule LiveViewStudioWeb.TopSecretLive do
  use LiveViewStudioWeb, :live_view

  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  def render(assigns) do
    ~L"""
    <h1>Top Secret</h1>
    <div id="top-secret">
      <img src="images/spy.svg">
      <div class="mission">
        <h2>Your Mission</h2>
        <h3>007</h3>
        <p>
          (should you choose to accept it)
        </p>
        <p>
          is detailed below...
        </p>
      </div>
    </div>
    """
  end
end
