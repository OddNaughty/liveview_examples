defmodule DemoAppWeb.PageView do
  use DemoAppWeb, :view
  alias Phoenix.LiveView.JS

  def display_temp(%{temperature: t}=assigns) when t < 0 do
    ~H"""
    <div class="bg-cyan-100 w-full">
      <p>Current temperature (freezing): <%= @temperature %></p>
    </div>
    """
  end

  def display_temp(%{temperature: t}=assigns) when t > 0 do
    ~H"""
    <div class="bg-cyan-100 w-full">
      <p>Current temperature: <%= @temperature %></p>
    </div>
    """
  end

  def display_temp_slot(assigns) do
    ~H"""
    <div class="bg-cyan-100 w-full">
      <p>Current temperature: <%= render_slot(@inner_block) %></p>
    </div>
    """
  end

  def presentation_temperature_card(assigns) do
    ~H"""
    <div class="flex flex-col items-center w-2/3 text-center">
      <h2 class="bg-cyan-500 w-full font-bold"><%= render_slot(@title) %></h2>
      <.display_temp temperature={@temperature}/>
    </div>
    """
  end

  def presentation_card(assigns) do
    ~H"""
    <div class="flex flex-col items-center w-2/3 text-center">
      <h2 class="bg-cyan-500 w-full font-bold"><%= render_slot(@title) %></h2>
      <div class="bg-cyan-100 w-full">
        <%= render_slot(@inner_block) %>
      </div>
    </div>
    """
  end

  def hide_modal(js \\ %JS{}) do
    js
    |> JS.hide(transition: "fade-out-scale", to: "#modal")
  end

  def modal(assigns) do
    ~H"""
    <div id="modal" class="phx-modal" phx-remove={hide_modal()} style="display: none">
      <div
        id="modal-content"
        class="phx-modal-content"
        phx-click-away={hide_modal()}
        phx-window-keydown={hide_modal()}
        phx-key="escape"
      >
        <button class="phx-modal-close" phx-click={hide_modal()}>✖</button>
        <p><%= @text %></p>
      </div>
    </div>
    """
  end
end
