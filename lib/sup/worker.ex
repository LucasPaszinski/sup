defmodule Sup.Worker do
  use GenServer

  # Public API

  def start_link(name) do
    agent_name = get_agent(name)
    value = Sup.WorkerAgent.get(agent_name)
    GenServer.start_link(__MODULE__, %{name: name, value: value}, name: name)
  end

  def get_agent(name) do
    "agent_#{Atom.to_string(name)}"
    |> String.to_atom()
  end

  def next_number(name) do
    GenServer.call(name, :next_number)
  end

  def increment_number(name, delta) do
    GenServer.cast(name, {:increment_number, delta})
  end

  # GenServer implementation

  def init(args) do
    # current_number = Sup.WorkerAgent.get()
    {:ok, args}
  end

  def handle_call(:next_number, _from, %{name: name, value: value}) do
    {:reply, value, %{name: name, value: value + 1}}
  end

  def handle_cast({:increment_number, delta}, %{name: name, value: value}) do
    {:noreply, %{name: name, value: value + delta}}
  end

  def terminate(_reason, %{name: name, value: value}) do
    Sup.WorkerAgent.update(get_agent(name), value)
  end
end
