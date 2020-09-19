defmodule Sup.Worker do
  use GenServer

  # Public API

  def start_link({stash_pid, name}) do
    GenServer.start_link(__MODULE__, stash_pid, name: name)
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

  def handle_call(:next_number, _from, current_number) do
    {:reply, current_number, current_number + 1}
  end

  def handle_cast({:increment_number, delta}, current_number) do
    {:noreply, current_number + delta}
  end

  # def terminate(_reason, current_number) do
  #   Sup.WorkerAgent.update(current_number)
  # end
end
