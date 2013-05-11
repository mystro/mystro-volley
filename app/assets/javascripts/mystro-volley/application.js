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
//= require_tree .

$(function(){
    $(document).on("click", ".deploy", function(){
        console.log("deploy");
        var u = $(this).data("url");
        console.log("deploy: "+u);
        $.get(u)
            .done(function(d){
                $("#deploy_dialog_contents").html(d);
            });
        bootbox.dialog($("#deploy_dialog").html(), [
            {
                "Cancel": function () {
                    console.log("cancel");
                }
            },
            {
                "Create": function () {
                    console.log("deploy");
                    var f = $("#deploy_form:last");
                    var u = f.attr("action");
                    console.log("post "+u);
                    data = f.serialize();
                    console.log(data);
                    bootbox.modal("please wait", "queueing job");
                    $.post(u, data, function(){
                        console.log("post done");
                        bootbox.hideAll();
                    });
//                    console.log("create");
//                    var f = $(".compute_form:last"); // because bootbox makes a clone
//                    data = f.serialize();
//                    console.log("data");
//                    console.log(f.serializeArray());
//                    bootbox.modal("please wait", "creating");
//                    console.log("post");
//                    $.post("/computes.json", data, function () {
//                        console.log("success");
//                        bootbox.hideAll();
//                    });
                }
            }
        ], {header: "Deploy"})
    });
});
