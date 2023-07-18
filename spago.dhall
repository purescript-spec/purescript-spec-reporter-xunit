{ name = "spec-reporter-xunit"
, license = "MIT"
, repository = "https://github.com/purescript-spec/purescript-spec-reporter-xunit.git"
, dependencies = [ "node-fs-aff", "spec", "transformers" ]
, packages = ./packages.dhall
, sources = [ "src/**/*.purs" ]
}
