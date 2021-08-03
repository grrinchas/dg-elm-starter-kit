module Config exposing
    ( Value
    , decode
    )

import Json.Decode as Decode



-- MODELS


type alias Value =
    {}



-- DECODERS


decode : Decode.Decoder Value
decode =
    Decode.succeed {}
