defmodule Room do
  @moduledoc """
  Uses a genserver to maintain a piano room.

  Contains %{ users: [user_id1, user_id2], code: code }
  """

  defdelegate start(name, default \\ []),             to: Interface
  defdelegate allow_user(name, user_id, code \\ nil), to: Interface

end
