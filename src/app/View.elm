module View exposing (view)

import Browser exposing (Document)
import Html exposing (..)
import Html.Attributes exposing (href, src)
import Messages exposing (Msg)
import Model exposing (Model)
import Route.Model exposing (Route(..))
import Route.View exposing (..)


view : Model -> Document Msg
view ({ nav, config} as model) =
    case nav.route of
        Home ->
            { title = "Home"
            , body =
                [ text "got to "
                , initialLink config
                    |> linkName.set "post 40"
                    |> linkRoute.set (Route.Model.post 40)
                    |> simpleLink
                ]
            }
        Post val ->
            { title = "Post"
            , body =
                [ text ("Post nr " ++ Debug.toString val)
                ]
            }

