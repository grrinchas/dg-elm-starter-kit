module View exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Http exposing (Error)
import Messages exposing (..)
import Models exposing (..)
import Routes exposing (..)


homePage: Html Msg
homePage =
    main_ []
        [ div [class "container"]
            [ div [class "row"]
                [ h1 [] [text "Welcome to DG elm starter kit"]
                , span [] [text "Development environment for Elm programming language"]
                , p [] [ a [href <| toPath UsersRoute] [text "Click here for GitHub users"]]
                ]
            ]
        ]


usersPage : Responsive -> List User -> Html msg
usersPage responsive users =
    case responsive of
        Mobile -> mobile users
        Tablet -> tablet users



mobile: List User -> Html msg
mobile users =
    main_ []
        [ul [class "collection"] <| List.map userItem users]


userItem: User -> Html msg
userItem user =
    li [class "collection-item avatar"]
        [ img [class "dg-avatar circle", src user.avatar] []
        , span [class "title"] [text user.login]
        ]


tablet: List User -> Html msg
tablet users =
    main_ [class "container"]
        [div [class "row"] <| List.map userCard users]



userCard : User -> Html msg
userCard user =
    div [class "col s6 m4 l3"]
    [div [class "card small"]
        [ div [class "card-image"]
         [img [src user.avatar, class "dg-avatar"] [] ]
        , div [class "card-content"]
            [
          span [class "card-title"] [text user.login]
            ]
         ]]



notFoundPage : Html msg
notFoundPage = h1 [] [text "404 Not found"]

errorPage : Error -> Html msg
errorPage error = text <| toString error


loading : Html msg
loading =
    div [ class "dg-loading" ]
        [ div [ class "preloader-wrapper active" ] <|
            List.map
                loaderPart
                [ "blue", "red", "yellow", "green" ]
        ]

loaderPart : String -> Html msg
loaderPart color =
    div [ class ("spinner-layer spinner-" ++ color) ]
        [ div [ class "circle-clipper left" ]
            [ div [ class "circle" ] []
            ]
        , div [ class "gap-patch" ]
            [ div [ class "circle" ] []
            ]
        , div [ class "circle-clipper right" ]
            [ div [ class "circle" ] []
            ]
        ]

