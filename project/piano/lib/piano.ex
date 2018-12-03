defmodule Piano do
  @moduledoc """
  This module very basically models a piano. It uses a genserver to keep track of which notes are currently
  being pressed, and has record/stop_recording functions that generate basic activity logs that can be parsed
  to generate MIDI sequences.
  """

  defdelegate start(),           to: Interface
  defdelegate press(),           to: Interface
  defdelegate release(),         to: Interface
  defdelegate start_recording(), to: Interface
  defdelegate stop_recording(),  to: Interface

end
