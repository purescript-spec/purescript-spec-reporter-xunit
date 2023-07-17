let config = ./spago.dhall

in config // {
  sources = config.sources # [ "test/**/*.purs" ],
  dependencies = config.dependencies #
    [ "aff"
    , "arrays"
    , "effect"
    , "either"
    , "exceptions"
    , "foldable-traversable"
    , "identity"
    , "maybe"
    , "newtype"
    , "node-buffer"
    , "node-fs"
    , "node-path"
    , "pipes"
    , "prelude"
    , "strings"
    ]
}
