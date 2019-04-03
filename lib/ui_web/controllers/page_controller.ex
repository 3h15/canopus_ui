defmodule UiWeb.PageController do
  use UiWeb, :controller

  def index(conn, _params) do
    time = Canopus.Clock.clock_time
    |> Canopus.Clock.in_paris_tz
    |> Timex.format!( "{h24}:{m}" )

    conn
    |> assign( :time, time)
    |> render( "index.html" )
  end

  def set_thermostat(conn, %{"sensor_id" => sensor_id, "target_temperature" => target_temperature} ) do
    {target_temperature, _} = Float.parse(target_temperature)
    GenServer.call(Canopus.Thermostat, {:set_target_temperature, sensor_id, target_temperature})

    conn
    |> redirect( to: "/" )
  end

  def set_heater(conn, %{"is_on" => is_on} ) when is_on in ["on", "off"] do
    GenServer.call(Canopus.Heater, {:set_heater, is_on})
    redirect(conn,  to: "/")
  end
end
