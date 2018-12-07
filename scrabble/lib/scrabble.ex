defmodule Scrabble do
  @moduledoc """
  Scrabble keeps the contexts that define your domain
  and business logic.

  Contexts are also responsible for managing your data, regardless
  if it comes from the database, an external API or others.
  """

  defstruct letters: [], finished_list: [], best_guess: ""

  def new_help(word) do
    letters = word
    word = letters |> String.replace("\r", "") |> String.graphemes()

    help = %Scrabble{letters: word} |>
    wordlength(String.length(letters))
    
  end

  def wordlength(help, 2) do
    scrabbleHelp = spawn(Scrabble, :twoLetterProcess, [])
    send scrabbleHelp, {help.letters, help, self()}
    receive do
      { help, _ } ->
        help
    end
  end

  def wordlength(help, 3) do
    scrabbleHelp = spawn(Scrabble, :twoLetterProcess, [])
    send scrabbleHelp, {help.letters, help, self()}
    receive do
      { help, _ } ->
        help
    end
  end

  def wordlength(help, 4) do
    scrabbleHelp = spawn(Scrabble, :twoLetterProcess, [])
    send scrabbleHelp, {help.letters, help, self()}
    receive do
      { help, _ } ->
        help
    end
    
  end

  def wordlength(help, 5) do
    scrabbleHelp = spawn(Scrabble, :twoLetterProcess, [])
    send scrabbleHelp, {help.letters, help, self()}
    receive do
      { help, _ } ->
        help
    end
  end

  def wordlength(help, 6) do
    scrabbleHelp = spawn(Scrabble, :twoLetterProcess, [])
    send scrabbleHelp, {help.letters, help, self()}
    receive do
      { help, _ } ->
        help
    end
  end

  def wordlength(help, 7) do
    scrabbleHelp = spawn(Scrabble, :twoLetterProcess, [])
    send scrabbleHelp, {help.letters, help, self()}
    receive do
      { help, _ } ->
        help
    end
  end

  def count_letters(help) do
    list = help.letters
    list |> Enum.reduce(%{}, fn x, acc -> Map.update(acc, x, 1, &(&1 + 1)) end)
  end

  def addToList(true, word, help) do
    #If word is in dictionary, add to finished list.
    help = %{help | finished_list: Enum.sort(help.finished_list ++ [word])} 
  end

  def addToList(false, _, _), do: ""

  def checkDict(word, help) do
    word = Enum.join(word)
    addToList(Enum.member?(Dictionary.word_list(), word), word, help)
  end

  def twoLetterProcess(word, help) do
    receive do
      {word, from} ->
        permuteList = permute(word)
        Enum.each(permuteList, fn _ -> checkDict(word, help) end)
        send from, {help, word}
    end
  end

  def threeLetterProcess(word, help) do
    receive do
      {word, from} ->
        permuteList = permute(word)
        val1 = 
        send from, {help, word}
    end
  end

  def fourLetterProcess(word, help) do
    receive do
      {word, from} ->
        send from, {help, word}
    end
  end

  def fiveLetterProcess() do
    
  end

  def sixLetterProcess() do
    
  end

  def sevenLetterProcess() do
    
  end

  def permute([]), do: [[]]

  def permute(list) do
    for x <- list, y <- permute(list -- [x]), do: [x|y]
  end

end
