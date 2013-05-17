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

$(function () {
    $(document).on("click", ".volley-deploy", function () {
        console.log("deploy");
        var u = $(this).data("url");
        console.log("deploy: " + u);
        $.get(u)
            .done(function (d) {
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
                    console.log("post " + u);
                    data = f.serialize();
                    console.log(data);
                    bootbox.modal("please wait", "queueing job");
                    $.post(u, data, function () {
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
    $(document).on("click", ".mv-tab-view", function () {
        var id = $(this).attr("data-id");
        var type = $(this).attr("data-type");
        var kids = $(this).attr("data-kids");
        var heir = {"projects": "branches", "branches": "versions", "versions": "files"};
        var grandkids = heir[kids];
        console.log("tab view click:" + id);
        $("#mv-" + type + " .mv-tab-view").removeClass("active");
        $(this).addClass("active");
        $.get("/plugins/volley/" + type + "/" + id + ".json", function (d) {
            console.log("recieved " + kids);
            var h = "";
            for (var i in d) {
                var n = d[i]["name"];
                var id = d[i]["_id"];
                console.log(kids + ": " + n);
                // %{<li id="branch-#{e.name}" data-id="#{e.id.to_s}" class="mv-tab-branch"><a href="#">#{e.name}</a></li>}
                if(grandkids) {
                    h += "<li data-id='" + id + "' class='mv-tab-view' data-type='" + kids + "' data-kids='" + grandkids + "'><a href='#'>" + n + "</a></li>";
                } else {
                    h += "<li><a href='#'>" + n + "</a></li>";
                }
            }
            $("#mv-" + kids + "-content").html(h);
        });
    });
});
