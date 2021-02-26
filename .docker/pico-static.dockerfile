FROM thevlang/vlang:alpine AS build

WORKDIR /pico-static

COPY . .

RUN v ./src/main.v

FROM alpine AS production

WORKDIR /pico-static

COPY --from=build /pico-static/src/main /pico-static/main

CMD ["/pico-static/main"]
