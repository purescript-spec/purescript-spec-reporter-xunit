module Test.Spec.Reporter.XunitSpec where

import Prelude

import Effect.Class (liftEffect)
import Node.Encoding (Encoding(UTF8))
import Node.FS.Sync (readTextFile, unlink)
import Test.Spec (itOnly, Spec, it, describe)
import Test.Spec.Assertions (fail)
import Test.Spec.Assertions.String (shouldContain)
import Test.Spec.Reporter.Xunit (xunitReporter)
import Test.Spec.Runner (run)

xunitSpec :: Spec Unit
xunitSpec = do
  describe "Test" $
    describe "Spec" $
      describe "Reporter" $
        describe "Xunit" do
          let doctype = "<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n"
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
      liftEffect $ do
        let path = "output/test.tmp.xml"
        run [xunitReporter { indentation: 2, outputPath: path }] spec
        contents <- readTextFile UTF8 path
        unlink path
        pure contents
