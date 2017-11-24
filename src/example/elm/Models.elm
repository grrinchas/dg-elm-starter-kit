module Models exposing (..)


type Responsive
    = Mobile
    | Tablet

type alias User =
    { login: String
    , id: Int
    , avatar: String
    , repos: String
    }

