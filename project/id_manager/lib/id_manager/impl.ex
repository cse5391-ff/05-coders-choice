defmodule IdManager.Impl do

  @chars "1234567890ABCDEFGHIJKLMNOPQRSTUVWXYZ" |> String.codepoints()

  def generate_id(type, length)
    when type in [:room, :user]
  do

    id = create_id(length)

    server_name = "#{type |> Atom.to_string()}_ids" |> String.to_atom()

    cond do
      MapSetStore.contains?(server_name, id) ->
        generate_id(type, length)
      true ->
        :ok = server_name |> MapSetStore.add([id])
        id
    end

  end

  defp create_id(length) do
    @chars
    |> Enum.take_random(length)
    |> Enum.join()
  end

end
