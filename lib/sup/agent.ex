# defmodule Sup.WorkerAgent do
#   use Agent

#   def start_link({initial_value, name}) do

#     Agent.start_link(fn -> initial_value end, name: name)
#   end

#   def get(name) do
#     Agent.get(name, & &1)
#   end

#   def update(name, new_value) do
#     Agent.update(name, fn _state -> new_value end)
#   end
# end
