defmodule HomemadePi.SwitchView do
  use HomemadePi.Web, :view

  def render("index.json", %{switches: switches}) do
    %{data: render_many(switches, HomemadePi.SwitchView, "switch.json")}
  end

  def render("show.json", %{switch: switch}) do
    %{data: render_one(switch, HomemadePi.SwitchView, "switch.json")}
  end

  def render("switch.json", %{switch: switch}) do
    %{id: switch.id,
      name: switch.name,
      state: switch.state}
  end
end
