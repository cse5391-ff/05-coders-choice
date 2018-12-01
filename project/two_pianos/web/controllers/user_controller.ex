defmodule TwoPianos.UserController do
  use TwoPianos.Web, :controller
  alias TwoPianos.User

  def index(conn, _params) do
    # Pulls all users from SQL repo and sends them to user index template
    users = Repo.all(User)
    render(conn, "index.html", users: users)
  end

  def show(conn, %{"id" => id}) do
    user = Repo.get!(User, id)
    render(conn, "show.html", user: user)
  end

  def new(conn, _params) do
    changeset = User.changeset(%User{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, _form_contents = %{"user" => user_params}) do

    # Generate changeset. Think of it like generating a user struct w/
    # params from the filled out form.
    changeset = User.changeset(%User{}, user_params)

    case Repo.insert(changeset) do
      # If above changeset struct satisfies rules of model's changeset...
      {:ok, _user} ->
        conn
        |> put_flash(:info, "User created successfully.")
        |> redirect(to: user_path(conn, :index))
      # If there was a failure, rerender form...
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end

  end

  def edit(conn, %{"id" => id}) do
    user = Repo.get!(User, id)
    changeset = User.changeset(user)
    render(conn, "edit.html", user: user, changeset: changeset)
  end

  def update(conn, %{"id" => id, "user" => user_params}) do

    user = Repo.get!(User, id)
    changeset = User.changeset(user, user_params)

    case Repo.update(changeset) do
      {:ok, user} ->
        conn
        |> put_flash(:info, "User updated successfully.")
        |> redirect(to: user_path(conn, :show, user))
      {:error, changeset} ->
        render(conn, "edit.html", user: user, changeset: changeset)
    end

  end

  def delete(conn, %{"id" => id}) do

    user = Repo.get!(User, id)
    Repo.delete!(user)

    conn
    |> put_flash(:info, "User deleted successfully.")
    |> redirect(to: user_path(conn, :index))

  end

end
