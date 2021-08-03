module Main exposing
    ( commands
    , initial
    , main
    , subscriptions
    )

import Browser
import Cmd
import Command
import Config
import Html
import Json.Decode as Decode
import Json.Encode as Encode
import Messages
import Model
import Update
import View



-- SUBSCRIPTIONS


subscriptions : Model.Value -> List (Sub Messages.Value)
subscriptions _ =
    []



-- COMMANDS


commands : Model.Value -> List Cmd.Value
commands _ =
    [ Cmd.example
    ]



-- INITIAL
-- INITIAL


flagsToModel : Decode.Value -> Result String Model.Value
flagsToModel flags =
    case Decode.decodeValue Config.decode flags of
        Ok config ->
            Ok (Model.initial config)

        Err err ->
            Err (Decode.errorToString err)


initial : Encode.Value -> ( Result String Model.Value, Cmd.Value )
initial flags =
    ( flagsToModel flags
    , Result.map commands (flagsToModel flags)
        |> Result.withDefault []
        |> Command.batch
    )



-- MAIN


main : Program Encode.Value (Result String Model.Value) Messages.Value
main =
    Browser.element
        { init =
            \flags ->
                initial flags
                    |> Tuple.mapSecond (Command.map Cmd.toCommands >> Command.list >> Cmd.batch)
        , view =
            \res ->
                case res of
                    Ok model ->
                        View.view model

                    Err err ->
                        Html.text err
        , update =
            \msg res ->
                case res of
                    Ok model ->
                        Tuple.mapFirst Ok (Update.update msg model)
                            |> Tuple.mapSecond (Command.map Cmd.toCommands >> Command.list >> Cmd.batch)

                    Err _ ->
                        ( res, Cmd.none )
        , subscriptions =
            \res ->
                Result.map subscriptions res |> Result.withDefault [] |> Sub.batch
        }
