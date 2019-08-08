import Browser
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick, onInput)


main = Browser.sandbox { init = init, update = update, view = view}


-- MODEL

type alias Model = 
  { counter: Int
  , name: String
  , email: String
  , password: String
  , passwordConfirmation: String
  }

init : Model
init =
  { counter = 0
  , name = ""
  , email = ""
  , password = ""
  , passwordConfirmation = ""
  }


-- UPDATE

type Msg = Increment | Decrement | Reset | Change String | Email String | Password String | PasswordConfirmation String

update : Msg -> Model -> Model

update msg model = 
  case msg of
    Increment -> { model | counter = model.counter + 1 }
    Decrement -> { model | counter = model.counter - 1 }
    Reset -> { model | counter = 0}
    Change newName -> { model | name = newName }
    Email email -> { model | email = email }
    Password password -> { model | password = password }
    PasswordConfirmation password -> { model | passwordConfirmation = password }


-- VIEW

view : Model -> Html Msg
view model =
  div []
    [ button [ onClick Decrement ] [ text "-" ]
    , div [] [ text (String.fromInt model.counter) ]
    , button [ onClick Increment ] [ text "+" ]
    , div [] [ button [ onClick Reset ] [ text "Reset" ] ]
    , input [ placeholder "item name", value model.name, onInput Change ] []
    , div [] [ text (String.reverse model.name) ]
    , div []
      [ viewInput "text" "Email" model.email Email
      , viewInput "password" "Password" model.password Password
      , viewInput "password" "Confirm password" model.passwordConfirmation PasswordConfirmation
      , viewValidation model
      ]
    ]

viewInput : String -> String -> String -> (String -> msg) -> Html msg
viewInput t p v toMsg =
  input [ type_ t, placeholder p, value v, onInput toMsg] []

viewValidation : Model -> Html msg
viewValidation model =
  if model.password == model.passwordConfirmation then
    if String.length model.password > 0 then
      if String.length model.password > 8 then
        div [ style "color" "green"] [ text "OK" ]
      else
        div [ style "color" "orange"] [ text "Password too short" ]
    else
      div [ style "color" "grey"] [ text "No errors" ]
  else
    div [ style "color" "red"] [ text "Passwords don't match" ]