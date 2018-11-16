defmodule Piano.Impl do

  # State struct, passed recursively in run()
  defstruct(
    keys_currently_pressed: nil,
    recording:              false
  )

  def start() do
    # Start MapSetStore genserver
    # Start Piano process (passing state struct w/ genserver name to run)
  end

  # send process messages with relevant data
  def press(id, keys),     do:
  def release(id, keys),   do:
  def start_recording(id), do:
  def stop_recording(id),  do:

  # Piano process
  defp run(state) do

    receive do

      { :press, keys } ->

      { :release, keys } ->

      { :start_recording } ->

      { :end_recording } ->

    end

    run(new_state)

  end

end
