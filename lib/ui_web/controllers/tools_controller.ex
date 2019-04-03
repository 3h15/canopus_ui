defmodule UiWeb.ToolsController do
  use UiWeb, :controller

  def index(conn, _params) do
    render( conn, "index.html")
  end

  def clock(conn, _params) do
    clock_time = Canopus.Clock.clock_time
    |> Canopus.Clock.in_paris_tz
    |> DateTime.to_iso8601

    ntp_time = Canopus.Clock.ntp_time
    |> Canopus.Clock.in_paris_tz
    |> DateTime.to_iso8601

    conn
    |> assign( :clock_time, clock_time)
    |> assign( :ntp_time, ntp_time)
    |> render( "clock.html" )
  end

  def set_clock(conn, params) do
    Canopus.Clock.ntp_to_clock
    clock( conn, params )
  end

end
