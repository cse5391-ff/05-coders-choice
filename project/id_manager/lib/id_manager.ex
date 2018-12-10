defmodule IdManager do

  alias IdManager.Impl

  defdelegate generate_id(type, length), to: Impl

end
