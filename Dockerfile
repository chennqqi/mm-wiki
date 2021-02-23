FROM golang:1.14.7-alpine3.12
RUN go env -w GOPROXY=https://goproxy.cn,direct
RUN echo "https://mirror.tuna.tsinghua.edu.cn/alpine/v3.12/main" > /etc/apk/repositories
RUN apk add build-base git musl-dev
COPY . /go/src/mm-wiki
WORKDIR /go/src/mm-wiki
RUN CGO_ENABLED=1 GOOS=linux GOARCH=amd64 go build -a -installsuffix cgo -ldflags="-w -s" -o /bin/mm-wiki

FROM alpine:3.12
RUN echo "https://mirror.tuna.tsinghua.edu.cn/alpine/v3.12/main" > /etc/apk/repositories && \
	apk add --no-cache -U tzdata && \
	addgroup -S app && \
	adduser app -S -G app -h /app

WORKDIR /app

COPY --from=0 /bin/mm-wiki mm-wiki
COPY static static
COPY views views

RUN chown -R app:app /app
ENV TZ=Asia/Shanghai

CMD [ "/app/mm-wiki", "--conf", "/app/conf/mm-wiki.conf" ]
