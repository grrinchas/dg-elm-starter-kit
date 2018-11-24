module Config.Decoder exposing (decodeConfig, decodeMode)

import Config.Model exposing (Config, Mode)
import Html.Attributes exposing (required)
import Json.Decode exposing (Decoder, andThen, bool, fail, string, succeed)
import Json.Decode.Pipeline as Pipeline
import Lib.Bool


decodeConfig : Decoder Config
decodeConfig =
    succeed Config
        |> Pipeline.required "mode" decodeMode
        |> Pipeline.required "fragment" (decodeBool)


decodeBool : Decoder Bool
decodeBool =
        string
            |> andThen
                ( Lib.Bool.fromString >> Maybe.map succeed >> Maybe.withDefault (fail "I can't decode bool") )

decodeMode : Decoder Mode
decodeMode =
        string
            |> andThen
                ( Config.Model.modeFromString >> Maybe.map succeed >> Maybe.withDefault (fail "I can't decode mode") )

