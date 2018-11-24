module  Lib.Bool exposing (..)


fromString: String -> Maybe Bool
fromString string =
    if String.toLower string == "true" then
        Just True
    else if String.toLower string == "false" then
        Just False
    else
        Nothing
