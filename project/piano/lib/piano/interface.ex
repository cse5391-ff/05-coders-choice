defmodule Piano.Interface do

  alias Piano.State

  def start() do
    %State{keys_pressed_store: MapSetStore.start()}
    # Start Piano process (passing state struct w/ genserver name to run)
  end

  # send process messages with relevant data
  def press(id, keys),     do:
  def release(id, keys),   do:
  def start_recording(id), do:
  def stop_recording(id),  do:

end
