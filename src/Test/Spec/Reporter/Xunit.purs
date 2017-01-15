module Test.Spec.Reporter.Xunit
       ( xunitReporter
       , defaultOptions
       ) where

import Prelude
import Data.XML as XML
import Test.Spec as S
import Control.Monad.Eff (Eff)
import Control.Monad.Eff.Console (CONSOLE)
import Control.Monad.Eff.Exception (EXCEPTION, message)
import Data.XML.PrettyPrint (print)
import Node.Encoding (Encoding(UTF8))
import Node.FS (FS)
import Node.FS.Sync (writeTextFile, exists, unlink)
import Node.Path (FilePath)
import Test.Spec.Runner (Reporter)
import Test.Spec.Reporter.Base (defaultReporter)

encodeResult :: S.Result -> Array XML.Node
encodeResult S.Success = []
encodeResult (S.Failure err) =
  [XML.Element
    "error"
    [XML.Attr "message" (message err)]
    [XML.Text (show err)]]

encodeGroup :: S.Group S.Result -> XML.Node
encodeGroup (S.Describe _ name groups) =
  XML.Element "testsuite" [XML.Attr "name" name] $ map encodeGroup groups
encodeGroup (S.It _ name result) =
  XML.Element "testcase" [XML.Attr "name" name] (encodeResult result)
encodeGroup (S.Pending name) =
  XML.Element "testcase" [XML.Attr "name" name] [XML.Element "skipped" [] []]

encodeSuite :: Array (S.Group S.Result) -> XML.Document
encodeSuite groups = XML.Document "1.0" "UTF-8" $ XML.Element "testsuite" [] $ map encodeGroup groups

removeIfExists :: forall e. FilePath -> Eff (fs :: FS, err :: EXCEPTION | e) Unit
removeIfExists path = do
  e <- exists path
  when e $ unlink path

type XunitReporterOptions = { outputPath :: FilePath
                            , indentation :: Int
                            }

defaultOptions :: XunitReporterOptions
defaultOptions = { indentation: 2, outputPath: "output/test.xml" }


xunitReporter :: ∀ e.
                 XunitReporterOptions
              -> Reporter (fs :: FS, err :: EXCEPTION, console :: CONSOLE | e)
xunitReporter options =
  defaultReporter options update summarize
  where
    update s _ = pure s

    summarize _  groups = do
      let xml = encodeSuite groups
      removeIfExists options.outputPath
      writeTextFile UTF8 options.outputPath (print options.indentation xml)
