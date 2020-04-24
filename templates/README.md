# Maki Module Templates

> Make flexible and consistent folder-based modular templates to harden your project's pattern.

# Templates

The `maki-modules` tool will look for module templates in the `templates` folder. For example:

```shell
npx maki-module make example-react ./src/components/NewModule
1   2           3    4             5
```

1. `npx` will execute the package without installation, if desired.
1. `maki-module` is the executable package
1. `make` is the command to make a new module
1. `example-react` is the template to use for the new module
1. Define the location where the new module is created

This example will copy the template from `templates/example-react` into the new module at `src/components/NewModule`.

# Token replacement

When the new module is copied to `src/components/NewModule`, all `__BaseName__` tokens are replaced in the file names and inside the files. In the case of the previous command the `__BaseName__` token value is extracted from the last folder of the path. I.e.:

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
| Camel      | `__baseName__`  | `newModule`  |
| Constant   | `__BASE_NAME__` | `NEW_MODULE` |
| Kebab      | `__base-name__` | `new-module` |
| Pascal     | `__BaseName__`  | `NewModule`  |
| Snake      | `__base_name__` | `new_module` |
