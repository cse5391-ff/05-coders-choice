# Alias this container as builder:
FROM bitwalker/alpine-elixir-phoenix as builder

# Install image preview generator tools
RUN apk add --no-cache file
RUN apk --update add imagemagick

# Install fonts
RUN apk --no-cache add msttcorefonts-installer fontconfig && \
 update-ms-fonts && \
 fc-cache -f

RUN apk --update add docker

WORKDIR /skydock

ENV MIX_ENV=dev

# Umbrella
# Copy mix files so we use distillery:
COPY . .

RUN mix do deps.get, deps.compile

WORKDIR /skydock
# CMD ["mix", "phx.server"] 