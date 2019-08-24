# Maki Module Templates

> Module templates to reduce project boilerplate.

# Templates

The `maki-modules` tool will look for module templates in a `template` folder. For example:

```shell
npx maki-module example-react ./src/components/NewModule
```

Will copy the template from `templates/example-react` into the new module at `src/components/NewModule`.

# Token replacement

When the new module is copied to `src/components/NewModule`, all `__BASENAME__` tokens are replaced in the file names and inside the files. In the case of the previous command the `__BASENAME__` token value is extracted from the last folder of the path. I.e.:

```
src
  components
    NewModule
      index.js
      NewModule.js
      NewModule.scss
      NewModule.test.js
```
