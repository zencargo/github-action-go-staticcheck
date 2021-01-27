FROM \
  alpine \
  AS install

ARG \
  STATICCHECK_VERSION

WORKDIR \
  /tmp

ENV \
  STATICCHECK_ARCHIVE_FILENAME="staticcheck_linux_amd64.tar.gz"

ENV \
  STATICCHECK_ARCHIVE_URL="https://github.com/dominikh/go-tools/releases/download/${STATICCHECK_VERSION}/${STATICCHECK_ARCHIVE_FILENAME}"

RUN \
  wget "${STATICCHECK_ARCHIVE_URL}"

RUN \
  wget "${STATICCHECK_ARCHIVE_URL}.sha256"

RUN \
  sha256sum -c "${STATICCHECK_ARCHIVE_FILENAME}.sha256"

RUN \
  tar \
    --directory /usr/local/bin \
    --extract \
    --file "${STATICCHECK_ARCHIVE_FILENAME}" \
    --gzip \
    --strip-components 1 \
    staticcheck/staticcheck

RUN \
  staticcheck --version


FROM \
  golang:alpine

COPY \
  --from=install \
  /usr/local/bin/staticcheck \
  /usr/local/bin/

ENV \
  CGO_ENABLED=0

ENTRYPOINT \
  ["/usr/local/bin/staticcheck"]

CMD \
  ["--help"]
