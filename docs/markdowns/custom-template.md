# Custom Templates

Create your own project structure by adding a YAML file in the `templates/` folder.

## Quick Start

1. Create a new file in `templates/` with a `.yaml` extension.
   - Example: `templates/express-api.yaml`
2. Add a `structure:` key at the top.
3. Define folders and files using nested YAML objects and lists.

## Rules

- `structure` is the root key for the template.
- Keys under `structure` represent folder or file names.
- A nested object means a folder that can contain more items.
- An empty object `{}` means an empty folder.
- A list (array) means a list of files to create in that folder.
- A file can be defined by setting its key to an empty string `""` (content is empty).

## Examples

### Empty folder

```yaml
structure:
  logs: {}
```

### Folder with files using list

```yaml
structure:
  src:
    controllers:
      - user.controller.js
      - auth.controller.js
```

### Folder with files using object keys

```yaml
structure:
  src:
    config:
      db.js: ""
      redis.js: ""
```

## Tip

Use `default.yaml` as a reference while you build your own template.
