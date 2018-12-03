defmodule Piano.Supervisor do

  use Supervisor

  def init(:ok) do
    children = [
      worker(Piano, [])
    ]

    supervise(children, strategy: :simple_one_for_one)
  end

end
