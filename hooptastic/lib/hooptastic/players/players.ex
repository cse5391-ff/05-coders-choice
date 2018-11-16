defmodule Hooptastic.Players do

  def get_player_stats(url) do
    case HTTPoison.get(url) do
      {:ok, %{status_code: 200, body: body}} ->
        req = Poison.decode!(body)
        IO.inspect(req)

      {:ok, %{status_code: 404}} ->
        IO.inspect("IT FAILED DUDE")

      {:error, %{reason: reason}} ->
        IO.inspect(reason)
    end
  end

  def get_all_player_data(num) do
    for x <- 2..num, do: get_player_stats("https://stats.nba.com/stats/commonplayerinfo/?PlayerID=#{x}")
  end
  #test = Hooptastic.Players.get_all_player_data(50)
  # get_player_stats(https://stats.nba.com/stats/commonplayerinfo/?PlayerID=2)

end
