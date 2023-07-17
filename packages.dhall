let upstream =
      https://github.com/purescript/package-sets/releases/download/psc-0.15.9-20230715/packages.dhall
        sha256:ca2801f7422d563de4ea4524efe6fa290186d202067409bc9cf359bb23acdfc5

    with spec.version = "v7.5.0"

in  upstream
