defmodule UserManager do

  alias UserManager.Interface

  defdelegate generate_user_id(length), to: Interface

end
