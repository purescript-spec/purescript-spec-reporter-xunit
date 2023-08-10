let upstream =
      https://github.com/purescript/package-sets/releases/download/psc-0.15.10-20230810/packages.dhall
        sha256:df6a4ae3eeea15089d731b19b4284bfa355f83a9d0504768701c1a32ca9fd080

in  upstream
  with node-buffer.version = "v9.0.0"
  with node-buffer.dependencies
       =
    [ "arraybuffer-types"
    , "effect"
    , "maybe"
    , "st"
    , "unsafe-coerce"
    , "nullable"
    ]
  with node-streams.version = "v9.0.0"
  with node-streams.dependencies
       =
    [ "aff"
    , "effect"
    , "exceptions"
    , "maybe"
    , "node-buffer"
    , "node-event-emitter"
    , "nullable"
    , "prelude"
    , "unsafe-coerce"
    ]
  with node-fs.version = "v9.1.0"
  with node-fs.dependencies
       =
    [ "datetime"
    , "effect"
    , "either"
    , "enums"
    , "exceptions"
    , "functions"
    , "integers"
    , "js-date"
    , "maybe"
    , "node-buffer"
    , "node-path"
    , "node-streams"
    , "nullable"
    , "partial"
    , "prelude"
    , "strings"
    , "unsafe-coerce"
    ]
