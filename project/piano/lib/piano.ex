defmodule Piano do
  @moduledoc """
  This module very basically models a piano. It uses a genserver to keep track of which notes are currently
  being pressed, and has record/stop_recording functions that generate basic activity logs that can be parsed
  to generate MIDI sequences.
  """


  defdelegate start(),           to: Impl
  defdelegate press(),           to: Impl
  defdelegate release(),         to: Impl
  defdelegate start_recording(), to: Impl
  defdelegate stop_recording(),  to: Impl

end
