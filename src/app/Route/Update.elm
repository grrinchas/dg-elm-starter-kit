module Route.Update exposing (parseRoute, update)

import Browser exposing (UrlRequest(..))
import Browser.Navigation
import Config.Model exposing (Config, Mode(..))
import Lib.Extra
import Messages exposing (Msg)
import Model exposing (Model, modelNav)
import Monocle.Lens as Lens exposing (compose)
import Route.Messages exposing (RouteMsg(..))
import Route.Model exposing (Navigation, Route, navigationRoute)
import Url exposing (Url)


parseRoute : Url -> Model -> ( Model, Cmd Msg )
parseRoute url ({ nav, config } as model) =
    let routeMapper newRoute =
           case newRoute == nav.route of
               True ->
                    model
                       |> Lib.Extra.noCommands
               False ->
                   model
                        |> (compose modelNav navigationRoute).set newRoute
                        |> Lib.Extra.withCommands
                            [ Url.toString url
                                |> Browser.Navigation.pushUrl nav.key
                            ]
    in
        Route.Model.fromUrl config url
            |> Maybe.map routeMapper
            |> Maybe.withDefault (model, Cmd.none)


update : RouteMsg -> Model -> ( Model, Cmd Msg )
update msg ({ nav } as model) =
    case msg of
        OnUrlRequest req ->
            case req of
                Internal url ->
                    parseRoute url model

                External href ->
                    model
                        |> Lib.Extra.withCommands
                            [ Browser.Navigation.load href
                            ]

        OnUrlChange url ->
            parseRoute url model
