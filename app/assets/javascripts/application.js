// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks

var validateable = [];

function validateForm() {
    $(".invalid_input").removeClass("invalid_input");
    var errors = [];
    for (var i in validateable) {
        var el = $(validateable[i].id);
        var error = false;
        if (el[0] != undefined) {
            if (validateable[i].invalidWhen == "empty") {
                if (!el.val()) error = true;
            }
            else if (validateable[i].invalidWhen == "short") {
                if (el.val().length < 3) error = true;
            }
            else if (validateable[i].invalidWhen == "nan") {
                if (isNaN(el.val())) error = true;
            }
            else if (validateable[i].invalidWhen == "date") {
                if (el[0].valueAsDate == null &&
                    (el[0].value.length < 6   ||
                     el[0].value.length > 10) ) error = true;
            }
        }
        if (error) {
            el.addClass("invalid_input");
            errors.push(validateable[i].errorMsg);
        }
    }
    if (errors.length > 0) {
        rawHtml = "<h3>" +
                    errors.length + " error" + (errors.length>1 ? "s" : "") + " found:" +
                  "</h3>" +
                  "<ul>"
        for (var e in errors) {
            rawHtml += "<li>" + errors[e] + "</li>";
        }
        rawHtml += "</ul>";
        console.log(rawHtml);
        $("#error_explanation").html(rawHtml).removeClass("no_errors");
        return false;
    }
    return true;
}

$(function() {
    if (validateable.length > 0) {
        $("input[type=submit]").click(function(event) {
            if (!validateForm()) event.preventDefault();
        });
    }
    $(".alert").delay(2000).slideUp(400);
});
