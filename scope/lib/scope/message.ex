defmodule Message do
  defmodule State do
    defstruct(
      content: "",
      from: "",
      timestamps: "",
      urgency: ""
    )
  end
end
