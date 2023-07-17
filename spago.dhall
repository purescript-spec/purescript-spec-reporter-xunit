{ name = "spec-reporter-xunit"
, dependencies = [ "node-fs-aff", "spec", "transformers" ]
, packages = ./packages.dhall
, sources = [ "src/**/*.purs" ]
}
