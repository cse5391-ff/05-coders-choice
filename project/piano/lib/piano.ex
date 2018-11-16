defmodule Piano do
  @moduledoc """
  This module very basically models a piano. It uses a genserver to keep track of which notes are currently
  being pressed, and has record/stop_recording functions that generate basic activity logs that can be parsed
  to generate MIDI sequences.
  """

  defdelegate new_piano(),       to: Impl
  defdelegate press_key(),       to: Impl
  defdelegate release_key(),     to: Impl
  defdelegate start_recording(), to: Impl
  defdelegate stop_recording(),  to: Impl

end
