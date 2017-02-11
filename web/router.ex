defmodule Webbkoll.Router do
  use Webbkoll.Web, :router
  @default_locale Application.get_env(:webbkoll, :default_locale)

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug Webbkoll.MoreSecureHeaders
    plug Webbkoll.Locale, @default_locale
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", Webbkoll do
    pipe_through :browser

    get "/", SiteController, :index
  end

  scope "/:locale", Webbkoll do
    pipe_through :browser # Use the default browser stack

    get "/about", SiteController, :about
    get "/tech", SiteController, :tech
    get "/check",  SiteController, :check
    get "/status", SiteController, :status
    get "/results", SiteController, :results

    get "/", SiteController, :index
  end

  # Other scopes may use custom stacks.
  # scope "/api", Webbkoll do
  #   pipe_through :api
  # end
end