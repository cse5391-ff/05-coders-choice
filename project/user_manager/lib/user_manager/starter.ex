defmodule UserManager.Starter do

  def start() do
    :UserIdMSSSupervisor |> MapSetStore.DynamicSupervisor.start_child(:user_ids)
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
