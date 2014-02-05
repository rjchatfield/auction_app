// # Place all the behaviors and hooks related to the matching controller here.
// # All this logic will automatically be available in application.js.
// # You can use CoffeeScript in this file: http://coffeescript.org/

validateable = [
    {
        "id":           "#category_name",
        "invalidWhen":  "empty",
        "errorMsg":     "Please give your category a name."
    },
    {
        "id":           "#category_name",
        "invalidWhen":  "short",
        "errorMsg":     "Please give your category a longer name (minimum is 3 characters)."
    }
];
