module Test.Spec.Reporter.XunitSpec where

import Prelude

import Data.Time.Duration (Milliseconds(..))
import Effect.Aff (delay)
import Effect.Class (liftEffect)
import Node.Encoding (Encoding(UTF8))
import Node.FS.Sync (readTextFile, unlink, exists)
import Test.Spec (itOnly, Spec, it, describe)
import Test.Spec.Assertions (fail)
import Test.Spec.Assertions.String (shouldContain)
import Test.Spec.Reporter.Xunit (xunitReporter)
import Test.Spec.Runner (defaultConfig, run')

xunitSpec :: Spec Unit
xunitSpec = do
  describe "Test" $
    describe "Spec" $
      describe "Reporter" $
        describe "Xunit" do
          it "reports success" do
            let path1 = "output/success.tmp.xml"
            contents <- runXunit successSpec path1
            contents `shouldContain` "<testcase name=\"works\"></testcase>"
          it "reports failure" do
            let path2 = "output/error.tmp.xml"
            contents <- runXunit failureSpec path2
            contents `shouldContain` "<testcase name=\"fails\">"
            contents `shouldContain` "Error"

  where
    successSpec = describe "a" (itOnly "works" (pure unit))
    failureSpec = describe "a" (itOnly "fails" (fail "OMG"))

    -- Waits indefinitely for the file `fp` to appear, or until interrupted
    waitForFile fp m = do
      ex <- liftEffect $ exists fp
      if ex
        then pure unit
        else delay m *> waitForFile fp m

    runXunit spec path = do
      let config = defaultConfig { exit = false }
      liftEffect $ run' config [xunitReporter { indentation: 2, outputPath: path }] spec
      waitForFile path $ Milliseconds 1000.0
      contents <- liftEffect $ readTextFile UTF8 path
      liftEffect $ unlink path
      pure contents
