defmodule IdGenerator do

  alias IdGenerator.Impl

  defdelegate generate_id(length), to: Impl

end
