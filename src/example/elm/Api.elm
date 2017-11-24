module Api exposing (..)

import Http
import Json.Decode as Decode exposing (..)
import Json.Decode.Pipeline exposing (decode, required)
import Messages exposing (Msg)
import Models exposing (User)
import RemoteData


{- URL for fetching users from the GitHub -}
queryUsers : String
queryUsers = "https://api.github.com/users"

{- Command for getting users. First we fetch them from the GitHub,
   then decode JSON body to the User model and create a command
   with OnFetchUsers message -}
fetchUsers : Cmd Msg
fetchUsers =
    Http.get queryUsers decodeUsers
        |> RemoteData.sendRequest
        |> Cmd.map Messages.OnFetchUsers


{- First decode JSON as a list of users -}
decodeUsers: Decoder (List User)
decodeUsers = Decode.list  userDecoder

{- Decode each user -}
userDecoder: Decoder User
userDecoder =
    decode User
        |> required "login" Decode.string
        |> required "id" Decode.int
        |> required "avatar_url" Decode.string
        |> required "repos_url" Decode.string

