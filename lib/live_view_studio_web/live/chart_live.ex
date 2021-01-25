defmodule LiveViewStudioWeb.ChartLive do
  use LiveViewStudioWeb, :live_view

  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  def render(assigns) do
    ~L"""
    <div id="charting">
      <h1>Blood Sugar</h1>
      <canvas id="chart-canvas">
      </canvas>
    </div>
    """
  end
end
