module Test.Main where

import Prelude

import Test.Spec.Runner
import Test.Spec.Reporter.Console

import Test.Spec.Reporter.Xunit
import Test.Spec.Reporter.XunitSpec
import Data.XML.PrettyPrintSpec

main = run [consoleReporter, xunitReporter "output/test.xml"] do
  xunitSpec
  prettyPrintSpec
