{ name = "spec-reporter-xunit"
, license = "MIT"
, repository = "https://github.com/purescript-spec/purescript-spec-reporter-xunit.git"
, dependencies =
    [ "arrays"
    , "effect"
    , "either"
    , "exceptions"
    , "foldable-traversable"
    , "maybe"
    , "node-buffer"
    , "node-fs"
    , "node-path"
    , "pipes"
    , "prelude"
    , "spec"
    , "strings"
    , "transformers"
    ]
, packages = ./packages.dhall
, sources = [ "src/**/*.purs" ]
}
