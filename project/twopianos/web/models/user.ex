defmodule Twopianos.User do
  use Twopianos.Web, :model

  schema "users" do

    field :email,        :string
    field :encrypt_pass, :string
    field :password,     :string, virtual: true

    timestamps()

  end

  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:email, :password])
    |> validate_required([:email, :password])
    |> unique_constraint(:email)
  end

end
