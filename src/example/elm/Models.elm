module Models exposing (..)

{- Represents size of the browser's window. At the moment we have Mobile and Tablet. The actual dimensions
   are contained in the update function in the Main module.-}
type Responsive
    = Mobile
    | Tablet

{- Represents GitHub user. While actual GitHub user has many more fields, we are only interested in its
   login name, id and the avatar. -}
type alias User =
    { login: String
    , id: Int
    , avatar: String
    }

