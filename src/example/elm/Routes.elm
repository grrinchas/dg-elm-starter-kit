module Routes exposing (..)

import Navigation exposing (Location)
import UrlParser exposing (..)

{- Represents routes for the application. At the moment we have only three: Home, User and NotFound. -}
type Route
    = HomeRoute
    | UsersRoute
    | NotFoundRoute

{- Parser browser's navigation bar url. We return route based on its results.-}
parseLocation : Location -> Route
parseLocation location =
    case (parseHash matchers location) of
        Just route ->
            route

        Nothing ->
            NotFoundRoute

{- Actual matchers which we match url. -}
matchers : Parser (Route -> a) a
matchers =
     oneOf
         [ map HomeRoute top
         , map UsersRoute (s "users")
         ]


{- Given route returns String. Useful for links in the html. -}
toPath : Route -> String
toPath route =
        case route of
            HomeRoute ->
                "#"
            UsersRoute ->
                "#users"
            NotFoundRoute ->
                ""
