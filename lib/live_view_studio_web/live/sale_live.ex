defmodule LiveViewStudioWeb.SaleLive do
  use LiveViewStudioWeb, :live_view
  alias LiveViewStudio.Sales

  def mount(_params, _session, socket) do
    if connected?(socket) do
      :timer.send_interval(1000, self(), :tick)
    end

    {:ok, assignStat(socket)}
  end

  def render(assigns) do
    ~L"""
    <h1>Front Porch Light</h1>
    <center>
      <p> orderds: <%= @new_orderds %></p>
      <p> sales_amount: <%= @sales_amount %></p>
      <p> satisfaction: <%= @satisfaction %></p>
    </center>
    """
  end

  def handle_info(:tick, socket) do
    {:noreply, assignStat(socket)}
  end

  defp assignStat(socket) do
    assign(socket,
      new_orderds: Sales.new_orders(),
      sales_amount: Sales.sales_amount(),
      satisfaction: Sales.satisfaction()
    )
  end

  def handle_event("on", _, socket) do
    socket = assign(socket, :brightness, 100)
    {:noreply, socket}
  end
end
