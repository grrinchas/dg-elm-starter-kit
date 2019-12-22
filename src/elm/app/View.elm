module View exposing (view)

import Html exposing (..)
import Messages exposing (Msg)
import Model exposing (Model)


view : Model -> Html Msg
view ({ config } as model) =
    h1 [] [ text "Welcome to Elm Starter Kit" ]


