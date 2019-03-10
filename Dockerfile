FROM elixir:1.8.1-alpine as builder
RUN mix local.rebar --force && mix local.hex --force
WORKDIR /app
ENV MIX_ENV=prod

FROM builder as deps
COPY mix.* /app/
RUN mix do deps.get --only prod, deps.compile

FROM node:10.12-alpine as frontend
WORKDIR /app
COPY assets/package*.json /app/
COPY --from=deps /app/deps/phoenix /deps/phoenix
COPY --from=deps /app/deps/phoenix_html /deps/phoenix_html
RUN npm ci
COPY assets /app
RUN npm run deploy