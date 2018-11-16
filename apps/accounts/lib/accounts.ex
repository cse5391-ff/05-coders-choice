defmodule Accounts do
  @moduledoc """
  Accounts keeps the contexts that define your domain
  and business logic.

  Contexts are also responsible for managing your data, regardless
  if it comes from the database, an external API or others.
  """

  defdelegate get_user(id),                                     to: Accounts.Actions
  defdelegate get_user!(id),                                    to: Accounts.Actions
  defdelegate get_user_by(params),                              to: Accounts.Actions
  defdelegate get_user_by_username(username),                   to: Accounts.Actions
  defdelegate list_users(),                                     to: Accounts.Actions
  defdelegate api_register(username, email, password),          to: Accounts.Actions
  defdelegate auth_by_username_and_pass(username, given_pass),  to: Accounts.Actions
end
