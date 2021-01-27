# github-action-go-staticcheck

This action runs [staticcheck](https://staticcheck.io/) static analysis on a Go module.

## Example usage

Until GitHub Actions [supports `uses` in composite actions](https://github.com/actions/runner/issues/646), you'll need to add `actions/cache` before this action.

```yaml
- uses: actions/cache@v2
  with:
    path: ~/go/pkg/mod
    key: go-mod-${{ hashFiles('**/go.sum') }}
    restore-keys: |
      go-mod-

- uses: zencargo/github-action-go-staticcheck@v1
  with:
    path: my/go/module
    go-version: 1.15
```

## Inputs

### path

**Required**, default: `.`

Path of the module, relative to the GitHub workspace.

### go-version

**Required**, default: `1.15`

Verson of Go to [target](https://staticcheck.io/docs/#targeting-go-versions).

### staticcheck-version

**Required**, default: `latest`

Version of Staticcheck to run ([available versions](https://github.com/orgs/zencargo/packages/container/staticcheck/versions)).
