module Route.View exposing (..)


import Config.Model exposing (Config)
import Html exposing (Html, a, text)
import Html.Attributes exposing (href)
import Monocle.Lens exposing (Lens)
import Route.Model exposing (Route)

type alias Link =
    { config: Config
    , route : Route
    , class : List String
    , name: String
    }


initialLink: Config -> Link
initialLink config =
    { route = Route.Model.home
    , class = []
    , name = "link"
    , config = config
    }

linkRoute : Lens Link Route
linkRoute =
    Lens .route (\b a -> { a | route = b })

linkClass : Lens Link (List String)
linkClass =
    Lens .class (\b a -> { a | class = b })

linkName : Lens Link String
linkName =
    Lens .name (\b a -> { a | name = b })



simpleLink: Link -> Html msg
simpleLink {route, name, class, config} =
    a [Html.Attributes.class <| String.join "" class
    , href <| Route.Model.toString config route]
        [text name]
