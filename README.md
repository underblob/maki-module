# maki-module

> Make flexible and consistent folder-based modular templates to harden your project's pattern.

## Usage

In your project root, install a `templates` folder with an example inside:

```
npx maki-module install
```

After running `install` option, the `templates` folder will open in Finder. See the `README.md` there for more details about authoring templates.

To see all available commands:

```
npx maki-module help
```

## Windows

To use with Windows:

1. Open **GitBash** CLI
1. Configure `npm` to use **GitBash** as the default executable for scripts using one of the following commands:
    ```
    npm config set script-shell "C:\\Program Files (x86)\\git\\bin\\bash.exe"
    # For x64:
    npm config set script-shell "C:\\Program Files\\git\\bin\\bash.exe"
    ```
1. Execute the `npx` commands as noted in the instructions above

To revert the config:

```
npm config delete script-shell
```

## Requirements

- Node >= 8.5
- NPM >= 5.3

## Links

- [Github](https://github.com/underblob/maki-module)
- [NPM package](https://www.npmjs.com/package/maki-module)
- [Report a bug](https://github.com/underblob/maki-module/issues)
