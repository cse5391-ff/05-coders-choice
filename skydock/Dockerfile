# Alias this container as builder:
FROM bitwalker/alpine-elixir-phoenix as builder

WORKDIR /skydock

ENV MIX_ENV=dev

# Umbrella
# Copy mix files so we use distillery:
COPY . .

RUN mix do deps.get, deps.compile

WORKDIR /skydock
# CMD ["mix", "phx.server"] 