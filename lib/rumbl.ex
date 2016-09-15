defmodule Rumbl do
  use Application

  # See http://elixir-lang.org/docs/stable/elixir/Application.html
  # for more information on OTP Applications
  def start(_type, _args) do
    import Supervisor.Spec

    # Define workers and child supervisors to be supervised
    children = [
      # Start the Ecto repository
      # supervisor(Rumbl.Repo, []),
      # Start the endpoint when the application starts
      supervisor(Rumbl.Endpoint, []),
      # Start your own worker by calling: Rumbl.Worker.start_link(arg1, arg2, arg3)
      # worker(Rumbl.Worker, [arg1, arg2, arg3]),
    ]

    # See http://elixir-lang.org/docs/stable/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Rumbl.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    Rumbl.Endpoint.config_change(changed, removed)
    :ok
  end

end

defmodule Rumbl.Repo do

  @moduledoc """
  In memory Repository
  """

  def get(module, id) do
    Enum.find all(module), fn map -> map.id == id end
  end

  def get_by(module, params) do
    Enum.find all(module), fn map ->
      Enum.all?(params, fn {key, val} -> Map.get(map, key) == val end)
    end
  end


  def all(Rumbl.User) do
    [%Rumbl.User{id: "1", name: "Jose", username: "josevalim", password: "elixir"},
     %Rumbl.User{id: "2", name: "Bruce", username: "redrapids", password: "7langs"},
     %Rumbl.User{id: "3", name: "Chris", username: "chrismccord", password: "phx"}]
  end
  def all(_module), do: []
end
