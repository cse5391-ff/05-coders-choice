defmodule UserManager do

  alias UserManager.Impl

  defdelegate create_user_id(), to: Impl

end
