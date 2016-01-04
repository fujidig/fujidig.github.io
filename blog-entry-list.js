"use strict";

$(function () {
	var url = "https://ajax.googleapis.com/ajax/services/feed/load?v=1.0";
	var $container = $("#blog-entry-list");
	$.ajax({
		url: url,
		data: {q: "http://fujidig.hatenablog.com/feed", num: 10},
		dataType: "jsonp"
	}).done(function (res) {
		var $ul = $("<ul/>");
		res.responseData.feed.entries.forEach(function (entry) {
			$ul.append($("<li/>").append($("<a/>").attr("href", entry.link).text(entry.title)));
		});
		$container.append($ul);
	}).fail(function () {
		$container.append($("<p/>").text("(ブログ記事を取得できませんでした)"));
	})
});