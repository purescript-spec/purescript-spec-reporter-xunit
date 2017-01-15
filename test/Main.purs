module Test.Main where

import Prelude
import Control.Monad.Eff (Eff)
import Control.Monad.Eff.Exception (EXCEPTION)
import Data.XML.PrettyPrintSpec (prettyPrintSpec)
import Node.FS (FS)
import Test.Spec.Reporter.Xunit (xunitReporter, defaultOptions)
import Test.Spec.Reporter.XunitSpec (xunitSpec)
import Test.Spec.Runner (RunnerEffects, run)

main :: Eff (RunnerEffects (fs :: FS, err :: EXCEPTION)) Unit
main = run reporters do
  xunitSpec
  prettyPrintSpec

  where
    reporters = [ xunitReporter (defaultOptions { outputPath = "output/test.xml" } ) ]
