FROM thevlang/vlang:alpine AS build

WORKDIR /pico-static

COPY ./src .

RUN v ./main.v

FROM alpine AS production

WORKDIR /pico-static

COPY --from=build /pico-static/src/main /pico-static/main

CMD ["/pico-static/main"]
