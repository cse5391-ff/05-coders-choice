defmodule Dictionary do

  defdelegate word_list(), to: Dictionary.WordList

end
