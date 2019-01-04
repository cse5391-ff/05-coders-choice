defmodule UserManager.Impl do

  def create_user_id() do

    user_id = IdGenerator.generate_id()

    # This is kinda gross, rethink later. Opens up concurrency can of worms...
    # LEARN FROM ACTOR MODEL. Whole point is to limit action to that specific actor.
    # Add add_if_not_present() that returns nil or something specific if it already is in set.
    if MapSetStore.contains?(:user_ids, user_id) do
      create_user_id()
    else
      MapSetStore.add(:user_ids, [user_id])
      user_id
    end

  end

end
