defmodule UserManager do

  alias UserManager.Impl

  defdelegate generate_user_id(length), to: Impl

end
