defmodule PlugHalt.Router do
  use PlugHalt.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
  end

  pipeline :halt do
    plug :stop
  end

  pipeline :halt_again do
    plug :stop
  end

  scope "/", PlugHalt do
    pipe_through [:halt, :halt_again, :browser] # Use the default browser stack

    get "/", PageController, :index
  end

  # Other scopes may use custom stacks.
  # scope "/api", PlugHalt do
  #   pipe_through :api
  # end

  defp stop(conn, _opts) do
    conn |> send_resp(200, "This errors the second time") |> halt
  end
end

