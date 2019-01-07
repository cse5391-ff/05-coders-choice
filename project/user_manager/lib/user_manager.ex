defmodule UserManager do
  @moduledoc """
  Handles generation of user_ids
  """


  alias UserManager.Interface

  defdelegate generate_user_id(length), to: Interface

end
