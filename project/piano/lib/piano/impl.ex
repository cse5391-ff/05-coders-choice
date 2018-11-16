defmodule Piano.Impl do

  def start() do

  end

  def press(id, keys) do

  end

  def release(id, keys) do

  end

  def start_recording(id)

  end

  def stop_recording(id)

  end

  defp run() do

    receive do

      { :press, keys } ->

      { :release, keys } ->

      { :start_recording } ->

      { :end_recording } ->

    end

    run()

  end

end
