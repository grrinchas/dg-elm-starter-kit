module Route.Model exposing
    ( Breadcrumb
    , Navigation
    , Route(..)
    , home
    , isHome
    , fromUrl
    , toString
    , navigationRoute
    , isPost
    , post
    )

import Browser.Navigation exposing (Key)
import Config.Model exposing (Config, Mode(..))
import Monocle.Lens exposing (Lens)
import Url exposing (Url)


type alias Navigation =
    { key : Key
    , route : Route
    }


type alias Breadcrumb =
    List Route


navigationRoute : Lens Navigation Route
navigationRoute =
    Lens .route (\b a -> { a | route = b })


type Route
    = Home
    | Post Int


name: Route -> String
name route =
    case route of
        Home -> ""
        Post val -> "post/" ++ Debug.toString val


fromUrl: Config -> Url -> Maybe Route
fromUrl {fragment} url =
    let fromString path =
           case List.filter ((/=)"") <| String.split "/"path of
               [] -> Just Home
               ["post", val] ->
                   String.toInt val
                       |> Maybe.map Post
               _ -> Nothing
    in case fragment of
        True ->
            Maybe.withDefault "" url.fragment
                |> fromString
        False ->
            String.dropLeft 1 url.path
                |> fromString


breadcrumb: Route -> Breadcrumb
breadcrumb route =
    case route of
        Home -> []

        Post val -> [Post val]




toString: Config -> Route -> String
toString {fragment} route =
    let base =
         breadcrumb route
            |> List.map name
            |> String.join "/"
    in
        case fragment of
        True ->
            "#" ++ base
        False ->
            "/" ++ base


post : Int -> Route
post =
   Post


home : Route
home =
   Home

isPost: Route -> Bool
isPost route =
    case route of
        Post _ -> True
        _ -> False

isHome : Route -> Bool
isHome =
    (==) home
