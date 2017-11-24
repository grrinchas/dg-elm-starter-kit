module Routes exposing (..)

import Navigation exposing (Location)
import UrlParser exposing (..)

type Route
    = HomeRoute
    | UsersRoute
    | NotFoundRoute

parseLocation : Location -> Route
parseLocation location =
    case (parseHash matchers location) of
        Just route ->
            route

        Nothing ->
            NotFoundRoute

matchers : Parser (Route -> a) a
matchers =
     oneOf
         [ map HomeRoute top
         , map UsersRoute (s "users")
         ]


toPath : Route -> String
toPath route =
        case route of
            HomeRoute ->
                "#"
            UsersRoute ->
                "#users"
            NotFoundRoute ->
                ""
