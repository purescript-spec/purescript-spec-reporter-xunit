module Test.Spec.Fixtures where

import Prelude
import Test.Spec (Spec, describe, it, pending)
import Test.Spec.Assertions (shouldEqual)

successTest :: Spec Unit
successTest =
  describe "a" do
    describe "b" do
      it "works" do
        1 `shouldEqual` 1

sharedDescribeTest :: Spec Unit
sharedDescribeTest =
  describe "a" do
    describe "b" do
      it "works" do
        1 `shouldEqual` 1
    describe "c" do
      it "also works" do
        1 `shouldEqual` 1

failureTest :: Spec Unit
failureTest = it "fails" $ 1 `shouldEqual` 2

pendingTest :: Spec Unit
pendingTest = pending "is not written yet"
