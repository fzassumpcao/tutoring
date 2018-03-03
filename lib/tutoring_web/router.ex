defmodule TutoringWeb.Router do
  use TutoringWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", TutoringWeb do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
    resources "/students", StudentController do
      resources "/classes", ClassController
    end
    resources "/classes", ClassController
  end

  # Other scopes may use custom stacks.
  # scope "/api", TutoringWeb do
  #   pipe_through :api
  # end
end
