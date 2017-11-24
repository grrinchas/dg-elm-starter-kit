module Main exposing (..)

import Api exposing (fetchUsers)
import Html exposing (Html, div, img, text)
import Messages exposing (..)
import Platform.Cmd exposing (batch)
import Models exposing (..)
import Navigation exposing (Location, newUrl)
import RemoteData exposing (WebData)
import Routes exposing (Route(HomeRoute, NotFoundRoute, UsersRoute), parseLocation, toPath)
import Task
import View
import Window



{- Model for the application. Users are the WebData from the server,
   Route is the current location in the browser navigation bar, Responsive
   represents size of the browser's window. -}
type alias Model =
    { users: WebData (List User)
    , route: Route
    , responsive: Responsive
    }

{- Initialization of the model. -}
initialModel : Location -> Model
initialModel location =
    { users = RemoteData.Loading
    , route = parseLocation location
    , responsive = Mobile
    }

init : Location -> (Model, Cmd Msg)
init location =
    ( initialModel location, batch [fetchUsers, Task.perform OnWindowChange Window.size])


subscriptions : Model -> Sub Msg
subscriptions model =
    Window.resizes (\size -> OnWindowChange size)


page: Model -> Html Msg
page model =
    case model.route of
        HomeRoute -> View.homePage
        UsersRoute -> mapSuccess (View.usersPage model.responsive) model.users
        NotFoundRoute -> View.notFoundPage


mapSuccess : (a -> Html Msg) -> WebData a -> Html Msg
mapSuccess view response =
    case response of
        RemoteData.NotAsked ->
            text ""

        RemoteData.Loading ->
            View.loading

        RemoteData.Success data ->
            view data


        RemoteData.Failure error ->
            View.errorPage error


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
  case msg of
    OnFetchUsers response ->
     ( {model | users = response}, Cmd.none)
    OnLocationChange location ->
      ( { model |  route = parseLocation location}, Cmd.none)
    OnWindowChange size ->
      if (size.width <= 600) then
         ( { model | responsive = Mobile }, Cmd.none )
      else
         ( { model | responsive = Tablet }, Cmd.none )


main : Program Never Model Msg
main =
    Navigation.program Messages.OnLocationChange
        { init = init
        , view = page
        , update = update
        , subscriptions = subscriptions
        }
