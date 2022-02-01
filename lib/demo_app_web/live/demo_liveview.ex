defmodule DemoAppWeb.DemoLive do
  use DemoAppWeb, :live_view

  def render(assigns) do
    Phoenix.View.render(DemoAppWeb.PageView, "demo.html", assigns)
  end

  def mount(_params, params, socket) do
    ctx = do_mount(connected?(socket), params)
    {:ok, assign(socket, ctx)}
  end

  def handle_event("inc_temperature", _value, socket) do
    {:noreply, update(socket, :temperature, & &1 + 1)}
  end

  def handle_event("inc_temperature_slow", _value, socket) do
    :timer.sleep(2_000)
    {:noreply, update(socket, :temperature, & &1 + 1)}
  end

  def handle_event("keyup", value, socket) do
    IO.inspect("The event keyup has been triggered")
    {:noreply, update(socket, :keyup, fn _ -> value["value"] end)}
  end

  def handle_event("delayed_event", _, socket) do
    Process.send_after(self(), :delayed, 5_000)
    {:noreply, socket}
  end

  def handle_info(:delayed, socket) do
    IO.inspect("Delayed event")
    {:noreply, push_event(socket, "delayed", %{value: "My value"})}
  end

  def do_mount(true = _connected, params) do
    :timer.sleep(5_000)
    %{
      temperature: params["temperature"] || 20,
      keyup: ""
    }
  end

  def do_mount(false = _connected, params) do
    %{
      temperature: params["temperature"] || -10,
      keyup: ""
    }
  end
end
