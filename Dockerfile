FROM \
  golang:alpine

RUN \
  apk --no-cache add \
    curl \
    jq

RUN \
  staticcheck_download_url=$( \
    curl \
      --fail \
      --header "Accept: application/vnd.github.v3+json" \
      --show-error \
      --silent \
      https://api.github.com/repos/dominikh/go-tools/releases \
    | \
    jq --raw-output 'first(.[] | select(.prerelease | not) | .assets[] | select(.name == "staticcheck_linux_amd64.tar.gz") | .browser_download_url)' \
  ) \
  && \
  curl \
    --fail \
    --location \
    --show-error \
    --silent \
    "${staticcheck_download_url}" \
  | \
  tar \
    --directory /usr/local/bin \
    --extract \
    --file - \
    --gzip \
    --strip-components 1 \
    staticcheck/staticcheck \
  && \
  staticcheck --version

COPY \
  entrypoint \
  /usr/local/bin/

ENTRYPOINT \
  ["/usr/local/bin/entrypoint"]
