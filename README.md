# github-action-go-staticcheck

This action runs [staticcheck](https://staticcheck.io/) static analysis on a Go module.

## Example usage

```yaml
uses: zencargo/github-action-go-staticcheck@v1
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

Go version to [target](https://staticcheck.io/docs/#targeting-go-versions).
