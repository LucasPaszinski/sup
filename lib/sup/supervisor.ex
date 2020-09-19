defmodule Sup.Supervisor do
  # Automatically defines child_spec/1
  use Supervisor

  def start_link(init_arg) do
    Supervisor.start_link(__MODULE__, init_arg, name: __MODULE__)
  end

  @impl true
  def init(_init_arg) do
    children = [
      Supervisor.child_spec({Sup.WorkerAgent, {10, :agent_worker1}}, id: :agent_worker1),
      Supervisor.child_spec({Sup.Worker, :worker1}, id: :worker1),
      Supervisor.child_spec({Sup.WorkerAgent, {20, :agent_worker2}}, id: :agent_worker2),
      Supervisor.child_spec({Sup.Worker, :worker2}, id: :worker2)
    ]

    Supervisor.init(children, strategy: :one_for_one)
  end
end
