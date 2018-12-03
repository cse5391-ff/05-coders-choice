defmodule Piano.Process do

  def run(state) do

    receive do

      { :press, keys } ->

      { :release, keys } ->

      { :start_recording } ->

      { :end_recording } ->

    end

    run(new_state)

  end

end
