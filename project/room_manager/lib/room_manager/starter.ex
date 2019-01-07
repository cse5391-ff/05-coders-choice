defmodule RoomManager.Starter do

  def start() do

    :RoomManagerMSSSupervisor |> MapSetStore.DynamicSupervisor.start_child(:room_codes)
    :RoomManagerMSSSupervisor |> MapSetStore.DynamicSupervisor.start_child(:room_ids)

    :RoomManagerMSSupervisor  |> MapStore.DynamicSupervisor.start_child(:code_id_linker)

  end

  def child_spec(_) do
    %{
      id:      __MODULE__,
      start:   {__MODULE__, :start, []},
      type:    :worker,
      restart: :transient,
      shutdown: 500
    }
  end

end
