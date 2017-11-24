module Messages exposing (..)

import Navigation exposing (Location)
import RemoteData exposing (WebData)
import Models exposing (User)
import Window exposing (Size)

type Msg
    = OnFetchUsers (WebData (List User))
    | OnLocationChange Location
    | OnWindowChange Size
