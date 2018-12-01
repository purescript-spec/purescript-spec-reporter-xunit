module Test.Spec.Reporter.XunitSpec where

import Prelude

import Data.XML.PrettyPrint as PP
import Test.Spec (itOnly, Spec, it, describe)
import Test.Spec.Assertions (fail)
import Test.Spec.Assertions.String (shouldContain)
import Test.Spec.Reporter.Xunit (encodeSuite)
import Test.Spec.Runner (defaultConfig, runSpec')

xunitSpec :: Spec Unit
xunitSpec = do
  describe "Test" $
    describe "Spec" $
      describe "Reporter" $
        describe "Xunit" do
          it "reports success" do
            contents <- runXunit successSpec
            contents `shouldContain` "<testcase name=\"works\"></testcase>"
          it "reports failure" do
            contents <- runXunit failureSpec
            contents `shouldContain` "<testcase name=\"fails\">"
            contents `shouldContain` "Error"

  where
    successSpec = describe "a" (itOnly "works" (pure unit))
    failureSpec = describe "a" (itOnly "fails" (fail "OMG"))

    runXunit spec = do
      let config = defaultConfig { exit = false }
      PP.print 2 <$> encodeSuite <$> runSpec' config spec
