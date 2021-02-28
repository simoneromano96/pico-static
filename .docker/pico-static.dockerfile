FROM thevlang/vlang:alpine AS build

WORKDIR /pico-static

RUN ls -al

COPY . .

RUN ls -al

RUN ls -al ./mimedb

RUN v ./main.v

FROM alpine AS production

WORKDIR /pico-static

COPY --from=build /pico-static/main /pico-static/main

CMD ["/pico-static/main"]
