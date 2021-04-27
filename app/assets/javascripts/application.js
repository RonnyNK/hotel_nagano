// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery_ujs
//= require popper
//= require bootstrap
//= require bootstrap-datepicker
//= require_tree .

function showContiguous(val) {
    if (val > 1) {
        $(".form-check").removeClass("d-none");
    } else {
        $(".form-check").addClass("d-none");
    }
}

function beforeToday(today) {
    date_in = document.getElementById("date_in").value;
    if ( date_in >= today) {
        $("#date_in").removeClass("is-invalid");
        $("#search").prop("disabled", false);
        $("#search").removeClass("disabled");
    } else {
        $("#date_in").addClass("is-invalid");
        $("#search").prop("disabled", true);
        $("#search").addClass("disabled");
    }

}

function validateDate(val) {
    date_in = document.getElementById("date_in").value;
    date_out = val
    if (date_in <= date_out) {
        $("#date_out").removeClass("is-invalid");
        $("#search").prop("disabled", false);
        $("#search").removeClass("disabled");
    } else {
        $("#date_out").addClass("is-invalid");
        $("#search").prop("disabled", true);
        $("#search").addClass("disabled");
    }
}

function numberChecked(element){
    nb_selected = $(".room:checked").length;
    nb_rooms = document.getElementById("nb_rooms").value;
    if(nb_selected > nb_rooms){
        element.checked = false;
    } else if (nb_rooms > nb_selected){
        $("#reserve").prop("disabled", true)
        $("#reserve").addClass("disabled");
    } else {

        $("#reserve").prop("disabled", false)
        $("#reserve").removeClass("disabled");
    }
}

function reserving(element){
    nb_selected = $(".room:checked").length;
    nb_rooms = document.getElementById("nb_rooms").value;

    if(parseInt(nb_selected) === parseInt(nb_rooms) && element !== ""){
        $("#reserve").prop("disabled", false)
        $("#reserve").removeClass("disabled");
    } else {
        $("#reserve").prop("disabled", true)
        $("#reserve").addClass("disabled");
    }

}