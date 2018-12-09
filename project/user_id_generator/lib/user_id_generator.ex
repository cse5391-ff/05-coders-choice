defmodule UserIdGenerator do

  alias UserIdGenerator.Impl

  defdelegate generate_id(), to: Impl

end
