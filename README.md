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

import Test.Spec.Node
import Test.Spec.Reporter.Console
import Test.Spec.Reporter.Xunit

main = runNode [xunitReporter "path/to/output.xml"] do
  ...
```

## API

See [API](API.md).

## Contribute

If you have any issues or possible improvements please file them as
[GitHub Issues](https://github.com/owickstrom/purescript-spec-quickcheck/issues).
Pull requests requests are encouraged.

## License

[MIT License](LICENSE.md).
