defmodule IdGenerator.Impl do

  @chars "1234567890ABCDEFGHIJKLMNOPQRSTUVWXYZ" |> String.codepoints()

  def generate_id(length) do
    @chars
    |> Enum.take_random(length)
    |> Enum.join()
  end

end
