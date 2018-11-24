module Route.Messages exposing (RouteMsg(..))

import Browser exposing (UrlRequest)
import Url exposing (Url)


type RouteMsg
    = OnUrlRequest UrlRequest
    | OnUrlChange Url
