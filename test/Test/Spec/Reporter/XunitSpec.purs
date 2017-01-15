module Test.Spec.Reporter.XunitSpec where

import Prelude
import Control.Monad.Eff.Class (liftEff)
import Control.Monad.Eff.Exception (EXCEPTION)
import Node.Encoding (Encoding(UTF8))
import Node.FS (FS)
import Node.FS.Sync (readTextFile, unlink)
import Node.Process (PROCESS)
import Test.Spec (itOnly, SpecEffects, Spec, it, describe)
import Test.Spec.Assertions (fail)
import Test.Spec.Assertions.String (shouldContain)
import Test.Spec.Reporter.Xunit (xunitReporter)
import Test.Spec.Runner (run)

xunitSpec :: Spec (SpecEffects (fs :: FS, err :: EXCEPTION, process :: PROCESS)) Unit
xunitSpec = do
  describe "Test" $
    describe "Spec" $
      describe "Reporter" $
        describe "Xunit" do
          let doctype = "<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n"
          it "reports success" do
            contents <- runXunit successSpec
            contents`shouldContain` "<testcase name=\"works\"></testcase>"
          it "reports failure" do
            contents <- runXunit failureSpec
            contents `shouldContain` "<testcase name=\"fails\">"
            contents `shouldContain` "Error"

  where
    successSpec = describe "a" (itOnly "works" (pure unit))
    failureSpec = describe "a" (itOnly "fails" (fail "OMG"))

    runXunit spec = do
      liftEff $ do
        let path = "output/test.tmp.xml"
        run [xunitReporter { indentation: 2 , outputPath: path }] spec
        contents <- readTextFile UTF8 path
        unlink path
        pure contents
