defmodule ScrabbleTest do
  use ExUnit.Case

  alias Scrabble, as: Help

  #  doctest Help

  describe "a new helper" do

    setup do
      [ help: Help.new_help("hello") ]
    end

    test "test for two letter words", c do
      tester = Help.new_help("hi")
      assert tester.letters == ["h", "i"]
      assert tester.finished_list == "hi"
    end
  end

end