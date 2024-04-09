# Maki Module Templates

> Make flexible and consistent folder-based modular templates to harden your project's pattern.

# Templates

The `maki-module` tool will look for module templates in the `templates` folder. For example:

```shell
npx maki-module make --template=example-react --dest=./src/components/NewModule
1   2           3    4                         5
```

1. `npx` will execute the package without installing to your local project, if desired.
1. `maki-module` is the executable package
1. `make` is the command to make a new module
1. `--template` argument defines which template to use for the new module
1. `--dest` argument defines the location where the new module is created

This example will use the template from `templates/example-react` to create a new module at `src/components/NewModule`.

## Arguments reference

| Argument     | Optional | Description                                                      |
| ------------ | -------- | ---------------------------------------------------------------- |
| `--dest`     | N        | File path to the location of the new module                      |
| `--template` | N        | Which template to use for the new module                         |
| `--parents`  | Y        | Comma-delimited ancestors for `__parent-name[-N]__` tokens       |
| `--children` | Y        | Comma-delimited descendants for `__child-name[-N]__` tokens      |
| `--self`     | Y        | Use for `__self-name__` token replacement instead of folder name |

# Token replacement

When the new module is copied to `src/components/NewModule`, all `__self-name__` tokens are replaced in the file names and inside the files. In the case of the previous command the `__self-name__` token value is extracted from the last folder of the path defined by `--dest`. I.e.:

```
npx maki-module make example-react ./src/components/NewModule
                                                    ^^^^^^^^^
src
  components
    NewModule
      index.js
      new-module.scss
      NewModule.js
      NewModule.test.js
```

# Case Convention

Note in the previous example: the SASS file (`new-module.scss`) has a different case convention. To use different case conventions in your templates, follow this key:

| Convention | Token           | Example      |
| ---------- | --------------- | ------------ |
| Camel      | `__selfName__`  | `newModule`  |
| Constant   | `__SELF_NAME__` | `NEW_MODULE` |
| Kebab      | `__self-name__` | `new-module` |
| Pascal     | `__SelfName__`  | `NewModule`  |
| Snake      | `__self_name__` | `new_module` |

# Available tokens

| Argument                       | Tokens replaced                         |
| ------------------------------ | --------------------------------------- |
| `--parents=parent,grandParent` | `__parent-name-1__` `__parent-name-2__` |
| `--children=child,grandChild`  | `__child-name-1__` `__child-name-2__`   |
| `--dest=[ ... ]/moduleName`    | `__self-name__`                         |
| `--self=moduleName`            | `__self-name__`                         |
