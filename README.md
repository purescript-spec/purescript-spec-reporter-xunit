# purescript-spec-reporter-xunit [![Documentation](https://pursuit.purescript.org/packages/purescript-spec-reporter-xunit/badge)](https://pursuit.purescript.org/packages/purescript-spec-reporter-xunit)

purescript-spec-reporter-xunit is a reporter for
[purescript-spec](https://github.com/purescript-spec/purescript-spec) that outputs
Xunit reports consumable by Jenkins (perhaps others as well?).

## Usage

```bash
spago install spec-reporter-xunit
```

```purescript
module Main where

import Prelude

import Test.Spec.Reporter.Xunit (xunitReporter)
import Test.Spec.Runner (defaultConfig, runSpec)

main =
  runSpec [ xunitReporter { indentation: 2, outputPath: "output/test.xml" } ] do
    ...
```

## Contribute

If you have any issues or possible improvements please file them as
[GitHub Issues](https://github.com/purescript-spec/purescript-spec-reporter-xunit/issues).
Pull requests requests are encouraged.

## License

[MIT License](LICENSE.md).
