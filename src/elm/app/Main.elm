module Main exposing (commands, initial, main, subscriptions)

import Browser
import Config
import Html exposing (Html)
import Json.Decode as D exposing (Value)
import Messages exposing (Msg(..))
import Model exposing (Model)
import Update
import View



-- SUBSCRIPTIONS


subscriptions : Model -> List (Sub Msg)
subscriptions model =
    []



-- COMMANDS


commands : Model -> List (Cmd Msg)
commands model =
    []



-- INITIAL


initial : Value -> ( Result String Model, Cmd Msg )
initial flags =
    let
        model =
            case D.decodeValue Config.decode flags of
                Ok config ->
                    Ok (Model.initial config)

                Err err ->
                    Err (D.errorToString err)
    in
    ( model, Result.map commands model |> Result.withDefault [] |> Cmd.batch )



-- MAIN


main : Program Value (Result String Model) Msg
main =
    Browser.element
        { init = initial
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

                    Err _ ->
                        ( res, Cmd.none )
        , subscriptions =
            \res ->
                Result.map subscriptions res |> Result.withDefault [] |> Sub.batch
        }
