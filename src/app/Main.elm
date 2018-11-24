module Main exposing (..)

import Browser
import Browser.Navigation exposing (Key)
import Config.Decoder exposing (decodeConfig)
import Config.Model
import Json.Decode exposing (Value)
import Messages exposing (Msg(..))
import Model exposing (Model)
import Route.Messages exposing (RouteMsg(..))
import Route.Model
import Route.Update
import Update
import Url exposing (Url)
import View


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.batch
        []



initial : Value -> Url -> Key -> ( Model, Cmd Msg )
initial flags url key =
    let

        ( model, commands ) =
                case Json.Decode.decodeValue decodeConfig flags of
                    Ok config ->
                            Model.initial { key = key , route = Route.Model.home } config
                                |> Route.Update.parseRoute url
                    Err err ->
                        Debug.todo <| Debug.toString err


    in ( model , Cmd.batch [ commands ] )


main : Program Value Model Msg
main =
    Browser.application
        { init = initial
        , view = View.view
        , update = Update.update
        , subscriptions = subscriptions
        , onUrlRequest = OnRoute << OnUrlRequest
        , onUrlChange = OnRoute << OnUrlChange
        }

