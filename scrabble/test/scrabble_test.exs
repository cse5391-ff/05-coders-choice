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

    test "test for more two letter words", c do
      tester = Help.new_help("fa")
      assert tester.letters == ["f", "a"]
      assert tester.finished_list == "fa"
    end

    test "test for no creatable list", c do
      tester = Help.new_help("frk")
      assert tester.letters == ["f", "r", "k"]
      assert tester.finished_list == ""
    end

    test "test for three letter words", c do
      tester = Help.new_help("car")
      assert tester.letters == ["c", "a", "r"]
      assert tester.finished_list == "ar", "arc", "car"
    end

    test "test for more three letter words", c do
      tester = Help.new_help("res")
      assert tester.letters == ["r", "e", "s"]
      assert tester.finished_list == "er", "ers", "es", "re", "res", "ser"
    end

    test "test for four letter words", c do
      tester = Help.new_help("carp")
      assert tester.letters == ["c", "a", "r", "p"]
      assert tester.finished_list == "ar", "arc", "cap", "car", "carp", "crap", "pa", "pac", "par", "rap"
    end

    test "test for more four letter words", c do
      tester = Help.new_help("repl")
      assert tester.letters == ["r", "e", "p", "l"]
      assert tester.finished_list == "el", "er", "lep", "lerp", "pe", "pel", "per", "pre", "re", "rep"
    end
  end

end