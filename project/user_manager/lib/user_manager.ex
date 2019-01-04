defmodule UserManager do

  alias UserManager.Impl

  defdelegate create_user_id(length), to: Impl

end
