// # Place all the behaviors and hooks related to the matching controller here.
// # All this logic will automatically be available in application.js.
// # You can use CoffeeScript in this file: http://coffeescript.org/

var validateable = [
    {
        "id":           "#item_name",
        "invalidWhen":  "empty",
        "errorMsg":     "Please give your item a name."
    },
    {
        "id":           "#item_name",
        "invalidWhen":  "short",
        "errorMsg":     "Please give your item a longer name (minimum is 3 characters)."
    },
    {
        "id":           "#item_starting_price",
        "invalidWhen":  "empty",
        "errorMsg":     "Please provide a valid starting price."
    },
    {
        "id":           "#item_starting_price",
        "invalidWhen":  "nan",
        "errorMsg":     "Starting price must be a number."
    },
    {
        "id":           "#item_category_id",
        "invalidWhen":  "empty",
        "errorMsg":     "Please select a category."
    },
    {
        "id":           "#item_close_date",
        "invalidWhen":  "date",
        "errorMsg":     "Please provide a date."
    }
];
