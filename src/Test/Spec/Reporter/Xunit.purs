module Test.Spec.Reporter.Xunit (
  xunitReporter
  )
  where

import Prelude

import Control.Monad.Eff
import Control.Monad.Eff.Exception (EXCEPTION(), message)
import Control.Monad
import Data.Maybe
import Data.Foldable
import Node.Encoding
import Node.Path
import Node.FS (FS(..))
import Node.FS.Sync (writeTextFile, exists, unlink)

import qualified Test.Spec as S
import Test.Spec.Console
import Test.Spec.Summary
import Test.Spec.Reporter

import Data.XML hiding (Encoding())
import Data.XML.PrettyPrint

encodeResult :: S.Result -> Array Node
encodeResult S.Success = []
encodeResult (S.Failure err) =
  [Element
    "error"
    [Attr "message" (message err)]
    [Text (show err)]]

encodeGroup :: S.Group -> Node
encodeGroup (S.Describe name groups) =
  Element "testsuite" [Attr "name" name] $ map encodeGroup groups
encodeGroup (S.It name result) =
  Element "testcase" [Attr "name" name] (encodeResult result)

encodeSuite :: Array S.Group -> Document
encodeSuite groups = Document "1.0" "UTF-8" $ Element "testsuite" [] $ map encodeGroup groups

removeIfExists :: forall e. FilePath -> Eff (fs :: FS, err :: EXCEPTION | e) Unit
removeIfExists path = do
  e <- exists path
  when e $ unlink path

-- | Outputs an XML file at the given path that can be consumed by Xunit
-- | readers, e.g. the Jenkins plugin.
xunitReporter :: forall e. FilePath -> Reporter (fs :: FS, err :: EXCEPTION | e)
xunitReporter path groups = do
  let xml = encodeSuite groups
      s = print 2 xml
  removeIfExists path
  writeTextFile UTF8 path s

