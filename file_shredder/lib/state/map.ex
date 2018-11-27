defmodule State.Map do

  def start_link(map) do
    Agent.start_link(fn -> map end)
  end
  def start_link do  
    Agent.start_link(fn -> %{} end)  
  end

  def get(pid, key) do  
    Agent.get(pid, &Map.get(&1, key))  
  end  

  def put(pid, key, value) do  
    Agent.update(pid, &Map.put(&1, key, value))  
  end

end