defmodule Sup.Supervisor do
  # Automatically defines child_spec/1
  use Supervisor

  def start_link(init_arg) do
    Supervisor.start_link(__MODULE__, init_arg, name: __MODULE__)
  end

  @impl true
  def init(_init_arg) do
    IO.inspect(%{supervisor_id: self()})

    children = [
      #Supervisor.child_spec({Sup.WorkerAgent, {0, :agent1}}, id: :agent1),
      Supervisor.child_spec({Sup.Worker, {250, :worker1}}, id: :worker1),
      #Supervisor.child_spec({Sup.WorkerAgent, {0, :agent2}}, id: :agent2),
      Supervisor.child_spec({Sup.Worker, {300, :worker2}}, id: :worker2)
    ]

    IO.inspect(%{children: children})
    Supervisor.init(children, strategy: :one_for_one)
  end
end
