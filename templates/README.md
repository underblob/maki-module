# Maki Module Templates

> Modular templates to harden project boilerplate.

# Templates

The `maki-modules` tool will look for module templates in a `template` folder. For example:

```shell
npx maki-module example-react ./src/components/NewModule
```

Will copy the template from `templates/example-react` into the new module at `src/components/NewModule`.

# Token replacement

When the new module is copied to `src/components/NewModule`, all `__BaseName__` tokens are replaced in the file names and inside the files. In the case of the previous command the `__BaseName__` token value is extracted from the last folder of the path. I.e.:

```
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
