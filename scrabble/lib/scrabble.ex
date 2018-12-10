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
    letterlength = String.length(word)
    word = letters |> String.downcase() |> String.replace("\r", "") |> String.graphemes()

    help = %Scrabble{letters: word} |>
    wordlength(word, letterlength)
    help = %{help | finished_list: Enum.uniq(help.finished_list)}
    help = %{help | finished_list: Enum.join(help.finished_list, ", ")}
    help.finished_list
    
  end

  def wordlength(help, word, 2) do
    scrabbleHelp = spawn( Scrabble, :twoLetterProcess, [] )
    send scrabbleHelp, {help, word, self()}
    receive do
      { help, toAdd } ->
        help = %{help | finished_list: Enum.sort(help.finished_list ++ toAdd)}
        help
    end
  end

  def wordlength(help, word, 3) do
    scrabbleHelp = spawn(Scrabble, :threeLetterProcess, [])
    send scrabbleHelp, {help, word, self()}
    receive do
      { help, toAdd } ->
        help = %{help | finished_list: Enum.sort(help.finished_list ++ toAdd)}
        help
    end
  end

  def wordlength(help, word, 4) do
    scrabbleHelp = spawn(Scrabble, :fourLetterProcess, [])
    send scrabbleHelp, {help, word, self()}
    receive do
      { help, toAdd } ->
        help = %{help | finished_list: Enum.sort(help.finished_list ++ toAdd)}
        help
    end
    
  end

  def wordlength(help, word, 5) do
    scrabbleHelp = spawn(Scrabble, :fiveLetterProcess, [])
    send scrabbleHelp, {help, word, self()}
    receive do
      { help, toAdd } ->
        help = %{help | finished_list: Enum.sort(help.finished_list ++ toAdd)}
        help
    end
  end

  def wordlength(help, word, 6) do
    scrabbleHelp = spawn(Scrabble, :sixLetterProcess, [])
    send scrabbleHelp, {help, word, self()}
    receive do
      { help, toAdd } ->
        help = %{help | finished_list: Enum.sort(help.finished_list ++ toAdd)}
        help
    end
  end

  def count_letters(help) do
    list = help.letters
    list |> Enum.reduce(%{}, fn x, acc -> Map.update(acc, x, 1, &(&1 + 1)) end)
  end

  def addToList(true, word, help) do
    #If word is in dictionary, add to finished list.
    help = %{help | finished_list: Enum.sort(help.finished_list ++ word)} 
    help
  end

  def addToList(false, _, _), do: ""

  def checkDict(word) do
    word = Enum.join(word)
    Enum.member?(Dictionary.word_list(), word)
  end

  def twoLetterProcess() do
    receive do
      {help, word, from} ->
        permuteList = permute(word)
        templist = []
        templist = Enum.map(permuteList, fn(word) -> if(checkDict(word)) do templist ++ word else end end) |>
        Enum.filter(& !is_nil(&1))
        send from, {help, templist}
    end
  end

  def threeLetterProcess() do
    receive do
      {help, word, from} ->
        #run through the two letter process and add permutations of the 2-letter combinations to the list.
        val1 = Enum.at(word, 0)
        val2 = Enum.at(word, 1)
        tempword = String.graphemes("#{val1}#{val2}")
        help = wordlength(help, tempword, 2)
        val2 = Enum.at(word, 2)
        tempword = String.graphemes("#{val1}#{val2}")
        help = wordlength(help, tempword, 2)
        val1 = Enum.at(word, 1)
        tempword = String.graphemes("#{val1}#{val2}")
        help = wordlength(help, tempword, 2)
        #run through all permutations of the three letter word.
        permuteList = permute(word)
        templist = []
        templist = Enum.map(permuteList, fn(word) -> if(checkDict(word)) do templist ++ word else end end)
        templist = Enum.filter(templist, & !is_nil(&1))
        send from, {help, templist}
    end
  end

  def fourLetterProcess() do
    receive do
      {help, word, from} ->
        #run through the three letter process and add permutations of the 3 and 2 letter combinations to the list.
        val1 = Enum.at(word, 0)
        val2 = Enum.at(word, 1)
        val3 = Enum.at(word, 2)
        tempword = String.graphemes("#{val1}#{val2}#{val3}")
        help = wordlength(help, tempword, 3)
        val3 = Enum.at(word, 3)
        tempword = String.graphemes("#{val1}#{val2}#{val3}")
        help = wordlength(help, tempword, 3)
        val2 = Enum.at(word, 2)
        tempword = String.graphemes("#{val1}#{val2}#{val3}")
        help = wordlength(help, tempword, 3)
        val1 = Enum.at(word, 1)
        tempword = String.graphemes("#{val1}#{val2}#{val3}")
        help = wordlength(help, tempword, 3)
        #run through all permutations of the four letter word.
        permuteList = permute(word)
        templist = []
        templist = Enum.map(permuteList, fn(word) -> if(checkDict(word)) do templist ++ word else end end) |>
        Enum.filter(& !is_nil(&1))
        send from, {help, templist}
    end
  end

  def fiveLetterProcess() do
    receive do
      {help, word, from} ->
        #run through the four letter process and add permutations of the 2, 3, and 4 letter combinations to the list.
        val1 = Enum.at(word, 0)
        val2 = Enum.at(word, 1)
        val3 = Enum.at(word, 2)
        val4 = Enum.at(word, 3)
        tempword = String.graphemes("#{val1}#{val2}#{val3}#{val4}") #1, 2, 3, 4
        help = wordlength(help, tempword, 4)
        val4 = Enum.at(word, 4)
        tempword = String.graphemes("#{val1}#{val2}#{val3}#{val4}") #1, 2, 3, 5
        help = wordlength(help, tempword, 4)
        val3 = Enum.at(word, 3)
        tempword = String.graphemes("#{val1}#{val2}#{val3}#{val4}") #1, 2, 4, 5
        help = wordlength(help, tempword, 4)
        val2 = Enum.at(word, 2)
        tempword = String.graphemes("#{val1}#{val2}#{val3}#{val4}") #1, 3, 4, 5
        help = wordlength(help, tempword, 4)
        val1 = Enum.at(word, 1)
        tempword = String.graphemes("#{val1}#{val2}#{val3}#{val4}") #2, 3, 4, 5
        help = wordlength(help, tempword, 4)
        #run through all permutations of the four letter word.
        permuteList = permute(word)
        templist = []
        templist = Enum.map(permuteList, fn(word) -> if(checkDict(word)) do templist ++ word else end end) |>
        Enum.filter(& !is_nil(&1))
        send from, {help, templist}
    end
  end

  def sixLetterProcess() do
    receive do
      {help, word, from} ->
        #run through the five letter process and add permutations of the 2, 3, 4, and 5 letter combinations to the list.
        val1 = Enum.at(word, 0)
        val2 = Enum.at(word, 1)
        val3 = Enum.at(word, 2)
        val4 = Enum.at(word, 3)
        val5 = Enum.at(word, 4)
        tempword = String.graphemes("#{val1}#{val2}#{val3}#{val4}#{val5}") #1, 2, 3, 4, 5
        help = wordlength(help, tempword, 5)
        val5 = Enum.at(word, 5)
        tempword = String.graphemes("#{val1}#{val2}#{val3}#{val4}#{val5}") #1, 2, 3, 4, 6
        help = wordlength(help, tempword, 5)
        val4 = Enum.at(word, 4)
        tempword = String.graphemes("#{val1}#{val2}#{val3}#{val4}#{val5}") #1, 2, 3, 5, 6
        help = wordlength(help, tempword, 5)
        val3 = Enum.at(word, 3)
        tempword = String.graphemes("#{val1}#{val2}#{val3}#{val4}#{val5}") #1, 2, 4, 5, 6
        help = wordlength(help, tempword, 5)
        val2 = Enum.at(word, 2)
        tempword = String.graphemes("#{val1}#{val2}#{val3}#{val4}#{val5}") #1, 3, 4, 5, 6
        help = wordlength(help, tempword, 5)
        val1 = Enum.at(word, 1)
        tempword = String.graphemes("#{val1}#{val2}#{val3}#{val4}#{val5}") #2, 3, 4, 5, 6
        help = wordlength(help, tempword, 5)
        #run through all permutations of the four letter word.
        permuteList = permute(word)
        templist = []
        templist = Enum.map(permuteList, fn(word) -> if(checkDict(word)) do templist ++ word else end end) |>
        Enum.filter(& !is_nil(&1))
        send from, {help, templist}
    end
  end

  def permute([]), do: [[]]

  def permute(list) do
    for x <- list, y <- permute(list -- [x]), do: [x|y]
  end

end
