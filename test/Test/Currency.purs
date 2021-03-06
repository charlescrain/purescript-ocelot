module Test.Currency where

import Prelude

import Ocelot.Data.Currency (Cents(..), formatCentsToStrDollars, parseCentsFromDollarStr, parseCentsFromMicroDollars)
import Data.BigInt as BigInt
import Data.Maybe (Maybe(..))
import Test.Unit (TestSuite, suite, test)
import Test.Unit.Assert as Assert

currencyCheck :: TestSuite
currencyCheck = do
  suite "parsers" do
    test "parseCentsFromMicroDollars" do
      let expect = Just $ Cents $ BigInt.fromInt 1234
          result = parseCentsFromMicroDollars 12340000.0
      Assert.equal expect result

    test "parseCentsFromDollarStr NULL" do
      let expect = Nothing
          result = parseCentsFromDollarStr "NULL"
      Assert.equal expect result

    test "parseCentsFromDollarStr 12.34" do
      let expect = Just $ Cents $ BigInt.fromInt 1234
          result = parseCentsFromDollarStr "12.34"
      Assert.equal expect result

    test "parseCentsFromDollarStr 1234" do
      let expect = Just $ Cents $ BigInt.fromInt 123400
          result = parseCentsFromDollarStr "1234"
      Assert.equal expect result

    test "parseCentsFromDollarStr 1234.00" do
      let expect = Just $ Cents $ BigInt.fromInt 123400
          result = parseCentsFromDollarStr "1234.00"
      Assert.equal expect result

    test "parseCentsFromDollarStr 123.4" do
      let expect = Just $ Cents $ BigInt.fromInt 12340
          result = parseCentsFromDollarStr "123.4"
      Assert.equal expect result

    test "parseCentsFromDollarStr 1,234" do
      let expect = Just $ Cents $ BigInt.fromInt 123400
          result = parseCentsFromDollarStr "1,234"
      Assert.equal expect result

    test "parseCentsFromDollarStr 1,234.00" do
      let expect = Just $ Cents $ BigInt.fromInt 123400
          result = parseCentsFromDollarStr "1,234.00"
      Assert.equal expect result

    test "parseCentsFromDollarStr 1,234." do
      let expect = Just $ Cents $ BigInt.fromInt 123400
          result = parseCentsFromDollarStr "1,234."
      Assert.equal expect result

    test "formatCentsToStrDollars 0.00" do
      let result = formatCentsToStrDollars $ Cents $ BigInt.fromInt 0
      Assert.equal "0.00" result

    test "formatCentsToStrDollars 12.34" do
      let result = formatCentsToStrDollars $ Cents $ BigInt.fromInt 1234
      Assert.equal "12.34" result

    test "formatCentsToStrDollars 123.40" do
      let result = formatCentsToStrDollars $ Cents $ BigInt.fromInt 12340
      Assert.equal "123.40" result

    test "formatCentsToStrDollars 1,234.00" do
      let result = formatCentsToStrDollars $ Cents $ BigInt.fromInt 123400
      Assert.equal "1,234.00" result
