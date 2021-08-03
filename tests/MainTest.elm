module MainTest exposing (suite)

import Expect
import Test


suite : Test.Test
suite =
    Test.test "pass" <|
        \_ -> Expect.equal "" ""
