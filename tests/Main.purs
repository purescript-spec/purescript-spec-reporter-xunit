module Main where

import Test.Spec.Node
import Test.Spec.Reporter.Console
import Test.Spec.Reporter.Xunit
import Test.Spec.Reporter.XunitSpec
import Data.XML.PrettyPrintSpec

main = runNode [consoleReporter, xunitReporter "output/test.xml"] do
  xunitSpec
  prettyPrintSpec
