defmodule Accounts.Actions do
  import Ecto.Query

  alias Accounts.Repo
  alias Accounts.User

  def get_user(id) do
    Repo.get(User, id)
  end

  def get_user!(id) do
    Repo.get!(User, id)
  end

  def get_user_by(params) do
    Repo.get_by(User, params)
  end

  def get_user_by_username(username) do
    from(user in User, where: user.username == ^username)
    |> Repo.one()
    |> Repo.preload(:credential)
  end

  def list_users() do
    Repo.all(User)
  end

  defp register_user(attrs) do
    %User{}
    |> User.registration_changeset(attrs)
    |> Repo.insert()
  end

  def auth_by_username_and_pass(username, given_pass) do
    user = get_user_by_username(username)

    cond do
      user && Comeonin.Pbkdf2.checkpw(given_pass, user.credential.password_hash) ->
        new_token =
          %{username: username}
          |> Joken.token()
          |> Joken.with_claims(%{username: user.username})
          |> Joken.with_signer(Joken.hs256("VetoTheBeto2018"))
          |> Joken.sign()
          |> Joken.get_compact()

        {:ok, new_token}

      user ->
        {:error, :unauthorized}

      true ->
        Comeonin.Pbkdf2.dummy_checkpw()
        {:error, :not_found}
    end
  end

  def api_register(username, email, password) do
    m_credentials = %{
      username: username,
      password: password,
      password_hash:
        Joken.hs256(password).jwk
        |> Map.get("k")
    }

    register_user(%{
      username: username,
      email: email,
      password: m_credentials |> Map.get("k"),
      credential: m_credentials
    })
  end
end
