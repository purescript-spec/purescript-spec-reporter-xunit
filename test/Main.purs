module Test.Main where

import Prelude

import Data.XML.PrettyPrintSpec (prettyPrintSpec)
import Effect (Effect)
import Test.Spec.Reporter.Xunit (xunitReporter, defaultOptions)
import Test.Spec.Reporter.XunitSpec (xunitSpec)
import Test.Spec.Runner (run)

main :: Effect Unit
main = run reporters do
  xunitSpec
  prettyPrintSpec

  where
    reporters = [ xunitReporter (defaultOptions { outputPath = "output/test.xml" } ) ]
