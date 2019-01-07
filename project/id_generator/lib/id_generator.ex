defmodule IdGenerator do

  alias IdGenerator.Interface

  defdelegate generate_id(length), to: Interface

end
