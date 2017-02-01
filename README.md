# purescript-spec-reporter-xunit

purescript-spec-reporter-xunit is a reporter for
[purescript-spec](https://github.com/owickstrom/purescript-spec) that outputs
Xunit reports consumable by Jenkins (perhaps others as well?).

## Usage

```bash
bower install purescript-spec-reporter-xunit
```

```purescript
module Main where

import Prelude

import Test.Spec.Runner
import Test.Spec.Reporter.Xunit

main = run [ xunitReporter { indentation: 2, outputPath: "output/test.xml" } ] do
  ...
```

## API Documentation

See [the docs directory](docs/).

### Generating Docs

```bash
pulp docs
```

## Contribute

If you have any issues or possible improvements please file them as
[GitHub Issues](https://github.com/owickstrom/purescript-spec-reporter-xunit/issues).
Pull requests requests are encouraged.

## License

[MIT License](LICENSE.md).
