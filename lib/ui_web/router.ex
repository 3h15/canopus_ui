defmodule UiWeb.Router do
  use UiWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    # plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug Plug.Parsers, parsers: [:urlencoded, :multipart]
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", UiWeb do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
    post "/thermostat/:sensor_id", PageController, :set_thermostat
    get "/heater/:is_on", PageController, :set_heater

    get "/tools", ToolsController, :index

    get "/tools/clock", ToolsController, :clock
    get "/tools/set_clock", ToolsController, :set_clock

  end

  # Other scopes may use custom stacks.
  # scope "/api", UiWeb do
  #   pipe_through :api
  # end
end
