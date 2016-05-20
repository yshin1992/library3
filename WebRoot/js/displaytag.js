$(function() {
	//init selectofpagesize selected
	var current_page_size = $("#displaytag_page_size").val();
	$("#selectofpagesize option").each(function() {   
		if($(this).text()==current_page_size){
			$(this).prop('selected',true);
		}	
	}); 
	//table event
	$("#displaytag_table tbody tr").mouseover(function() {
		$(this).addClass("hover");
	});
	$("#displaytag_table tbody tr").mouseout(function() {
		$(this).removeClass("hover");
	});
	$("#displaytag_table thead tr :checkbox").on('click',function(event){
		if ($(this).prop("checked")) {
			$("#displaytag_table tbody tr :checkbox").not("[disabled='disabled']").prop("checked", true);
			$("#displaytag_table tbody tr :checkbox").not("[disabled='disabled']").parent().parent().addClass("select");
		} else {
			$("#displaytag_table tbody tr :checkbox").not("[disabled='disabled']").prop("checked", false);
			$("#displaytag_table tbody tr :checkbox").not("[disabled='disabled']").parent().parent().removeClass("select");
		}
		$("#displaytag_table tbody tr :checkbox").trigger("change");
	});
	
	function checkall(ischecked) {
		var checkval = true;
		$("#displaytag_table tbody tr :checkbox").each(function() {
			if (false == $(this).not("[disabled=disabled]").prop("checked")) {
				checkval = false;
				return false;
			}
		});
		if (checkval) {
			$("#displaytag_table thead tr :checkbox").prop("checked", true);
		}else{
			$("#displaytag_table thead tr :checkbox").prop("checked", false);
		}
	}
	$("#displaytag_table tbody tr").on('click', function(event){
		event.stopPropagation();
		if(false == $(this).find(":checkbox").prop("disabled"))
		{
			$("#displaytag_table tbody tr :checkbox").each(function() {
				$(this).prop("checked", false);
			});
			$("#displaytag_table tbody tr").each(function() {
				$(this).removeClass("select");
			});
			//var checkval = !$(this).find(":checkbox").prop("checked");
			$(this).find(":checkbox").prop("checked", true);
			$(this).find(":checkbox").trigger("change");
			//$(this).toggleClass("select");
			$(this).removeClass("select").addClass("select");
			checkall(true);
		}
		if(false== $(this).find(":radio").prop("disabled")){
			$("#displaytag_table tbody tr :radio").each(function() {
				$(this).prop("checked", false);
			});
			$("#displaytag_table tbody tr").each(function() {
				$(this).removeClass("select");
			});
			$(this).find(":radio").prop("checked", true);
			$(this).removeClass("select").addClass("select");
		}
	});
	$("#displaytag_table tbody tr :checkbox").on('click',function(event){
		event.stopPropagation();
		$(this).parent().parent().toggleClass("select");
		var checkval = $(this).prop("checked");
		checkall(checkval);
	});
	
	
	$("#gopage").click(function() {
		var pageUrl = $("#selectofpagesize").children("option:selected").val();
		var pagenum = "page=" + $("#inputpage").val();
		rgexp = /page=\d*/;
		if (rgexp.test(pageUrl)) {
			pageUrl = pageUrl.replace(/page=\d*/, pagenum);
		} else {
			pageUrl = pageUrl + "&" + pagenum;
		}
		/**
		 * struts 时使用
		pageUrl = replacetoken(pageUrl);
		pageUrl = replaceBeanSession(pageUrl);
		**/
		location.href = pageUrl;
	});
	$("#selectofpagesize").change(function() {
		var pageUrl = $(this).children("option:selected").val();
		var pageSize = $(this).children("option:selected").text();
		pageSize = "pageSize=" + pageSize;
		var rgexp = /pageSize=\d+/;
		if (rgexp.test(pageUrl)) {
			pageUrl = pageUrl.replace(/pageSize=\d+/, pageSize);
		} else {
			pageUrl = pageUrl + "&" + pageSize;
		}
		pageUrl = replacePageNum(pageUrl);
		/**
		pageUrl = replacetoken(pageUrl);
		pageUrl = replaceBeanSession(pageUrl);
		**/
		location.href = pageUrl;
	});
});

function replacetoken(pageUrl) {
	var stokenval = "struts.token="
			+ $("input[name='struts.token']").attr("value");
	return pageUrl.replace(/struts.token=[A-Za-z0-9]+/, stokenval);
}

function replacePageNum(pageUrl) {
	var pagenum = "page=" + $("#data_container").attr("pagenum");
	rgexp = /page=\d*/;
	if (rgexp.test(pageUrl)) {
		return pageUrl.replace(/page=\d*/, pagenum);
	} else {
		return pageUrl + "&" + pagenum;
	}
}

function replaceBeanSession(pageUrl) {
	rgexp = /beanSession=true/;
	if (rgexp.test(pageUrl)) {
		var pagenum = "beanSession=false";
		return pageUrl.replace(/beanSession=true/, pagenum);
	}
	else
	{
		return pageUrl;
	}
}
