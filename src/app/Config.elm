module Config exposing (..)


-- MODELS

import Json.Decode as D
type alias Config =
    {}



-- DECODERS


decode: D.Decoder Config
decode =
    D.succeed {}
