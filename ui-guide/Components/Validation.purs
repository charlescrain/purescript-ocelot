module UIGuide.Components.Validation where

import Prelude

import Data.Monoid (class Monoid)
import Data.Symbol (SProxy(..))
import Data.Variant (Variant)
import Ocelot.Core.Form (Form, formFromField, runForm)
import Ocelot.Core.Validation (validateNonEmptyStr, validateStrIsEmail)
import Polyform.Validation (V(..), hoistFnV)

----------
-- Form

-- These fields are available in our form
_password = SProxy :: SProxy "password"
_email = SProxy :: SProxy "email"

signupForm = { password: _, email: _ }
  <$> formFromField _password (hoistFnV validateNonEmptyStr)
  <*> formFromField _email (hoistFnV $ validateStrIsEmail "Not an email")

runSignupForm =
  runForm
    signupForm
    { password:
      { value: "longenough89"
      , shouldValidate: true
      }
    , email:
      { value: "notlongenough89"
      , shouldValidate: false
      }
    }
