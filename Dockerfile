FROM alpine:latest

RUN apk add --no-cache wpa_supplicant

COPY radius.sh .
RUN chmod +x radius.sh

CMD ["ash", "-c", "./radius.sh > /dev/null 2>&1"]


