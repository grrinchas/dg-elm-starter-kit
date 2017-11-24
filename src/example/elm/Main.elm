module Main exposing (..)

import Api exposing (fetchUsers)
import Html exposing (Html, div, img, text)
import Messages exposing (..)
import Platform.Cmd exposing (batch)
import Models exposing (..)
import Navigation exposing (Location, newUrl)
import RemoteData exposing (WebData)
import Routes exposing (..)
import Task
import View
import Window


{- Model for the application. Users are the WebData from the server, Route is the current location of the
   browser navigation bar, Responsive represents size of the browser's window. -}
type alias Model =
    { users: WebData (List User)
    , route: Route
    , responsive: Responsive
    }

{- Initialization of the model. We will be fetching users from the server at app's start. But it may take time,
   therefore we set state of the WebData to Loading. Also we parse location of the browser's navigation bar to
   get current Route. And set screen's size to Mobile. -}
initialModel : Location -> Model
initialModel location =
    { users = RemoteData.Loading
    , route = parseLocation location
    , responsive = Mobile
    }

{- Initialization of the application. It has our initial model. In addition using Platform.batch we will
   simultaneously perform multiple tasks. First we will fetch users and check what is the actual window size
   (maybe is not a Mobile). -}
init : Location -> (Model, Cmd Msg)
init location =
    ( initialModel location, batch [fetchUsers, Task.perform OnWindowChange Window.size])


{- We only subscribe to a change in Window size. -}
subscriptions : Model -> Sub Msg
subscriptions model =
    Window.resizes (\size -> OnWindowChange size)


{- Page is the view of the application. It checks the current route in the model and displays appropriate view. -}
page: Model -> Html Msg
page model =
    case model.route of
        HomeRoute -> View.homePage
        UsersRoute -> mapSuccess (View.usersPage model.responsive) model.users
        NotFoundRoute -> View.notFoundPage


{- Convenience function for mapping WebData to Html. If WebData is still fetching, then we display some Loading bar,
   if the request failed, then we display error message to the user, otherwise we apply Html function to the
   data which expects it. -}
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


{- Update function of the application which given message updates the model. -}
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


{- Entry point of the application. Instead of usual program, we use the one provided by Navigation package for
   routing. -}
main : Program Never Model Msg
main =
    Navigation.program Messages.OnLocationChange
        { init = init
        , view = page
        , update = update
        , subscriptions = subscriptions
        }
