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
      state: switch.state,
      rf_code_on: switch.rf_code_on,
      rf_code_off: switch.rf_code_off,
      ifttt_id: switch.ifttt_id}
  end
end
