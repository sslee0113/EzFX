<%@ page contentType="text/html; charset=UTF-8"%>
<meta http-equiv="X-UA-Compatible" content="IE=edge" charset="utf-8">
<title>EzTransfer MGMT</title>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/style.css" />

<script src="${pageContext.request.contextPath}/js/jquery/jquery-1.9.1.min.js"></script>
<!--
<script src="${pageContext.request.contextPath}/js/jquery/jquery.min.js"></script>
-->
<script src="${pageContext.request.contextPath}/js/jquery/jquery.easyui.min.js"></script> <!-- Easy UI  -->
<script src="${pageContext.request.contextPath}/js/jquery/datagrid-cellediting.js"></script> <!-- Easy UI  -->
<script src="${pageContext.request.contextPath}/js/jquery/datagrid-export.js"></script> <!-- Easy UI  -->
<script src="${pageContext.request.contextPath}/js/jquery/easyui/locale/easyui-lang-ko.js"></script>

<script src="${pageContext.request.contextPath}/js/ezfx.js"></script>
<!--
<script src="${pageContext.request.contextPath}/js/jquery/i18n/grid.locale-kr.js"></script>
<script src="${pageContext.request.contextPath}/js/jquery/jquery-ui.min.js"></script>
<script src="${pageContext.request.contextPath}/js/jquery/jszip.min.js"></script>
<script src="${pageContext.request.contextPath}/js/jquery/jquery-ui-timepicker-addon.js"></script>
<script src="${pageContext.request.contextPath}/js/jquery/context-menu.js"></script>
-->

<!--
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/js/jquery/jquery-ui.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/font-awesome-4.7.0/css/font-awesome.min.css">
-->

<!-- Easy UI -->
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/js/jquery/easyui/themes/icon.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/js/jquery/easyui/themes/demo.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/js/jquery/easyui/themes/gray/easyui.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/js/jquery/easyui/themes/ezfx.css">
<!-- Easy UI -->
    

<Script>
/*
$.datepicker.setDefaults({
	dateFormat: 'yy-mm-dd',
	prevText: '이전 달',
	nextText: '다음 달',
	monthNames: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
	monthNamesShort: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
	dayNames: ['일', '월', '화', '수', '목', '금', '토'],
	dayNamesShort: ['일', '월', '화', '수', '목', '금', '토'],
	dayNamesMin: ['일', '월', '화', '수', '목', '금', '토'],
	showMonthAfterYear: true,
	yearSuffix: '년'
});
*/
function getDate(){
	var d = new Date();
	var month = d.getMonth()+1;
	var day = d.getDate();
	var output = d.getFullYear() + "-" +
				(month<10 ? '0' : '') + month + "-" +
				(day<10 ? '0' : '') + day;
	
	return output;
}

function getParameterByName(name) {
    name = name.replace(/[\[]/, "\\[").replace(/[\]]/, "\\]");
    var regex = new RegExp("[\\?&]" + name + "=([^&#]*)"),
        results = regex.exec(location.search);
    return results === null ? "" : decodeURIComponent(results[1].replace(/\+/g, " "));
}

var adddDtPicker = function(element) {
	$(element).datetimepicker({
		dateFormat : 'yy-mm-dd',
		timeFormat : 'HH:mm:ss',
		prevText : '이전 달',
		nextText : '다음 달',
		monthNames : [ '1월', '2월', '3월', '4월', '5월', '6월', '7월',
				'8월', '9월', '10월', '11월', '12월' ],
		monthNamesShort : [ '1월', '2월', '3월', '4월', '5월', '6월',
				'7월', '8월', '9월', '10월', '11월', '12월' ],
		dayNames : [ '일', '월', '화', '수', '목', '금', '토' ],
		dayNamesShort : [ '일', '월', '화', '수', '목', '금', '토' ],
		dayNamesMin : [ '일', '월', '화', '수', '목', '금', '토' ],
		maxDate : new Date(2020, 0, 1),
		onSelect : function(dateText) {
			var splitIndex = dateText.indexOf(' ') + 1;
			var id = $(this).attr('id');
			var date = dateText.substr(0, splitIndex);
			var time = dateText.substr(splitIndex).replace(/:/g, '');
			if(id == 'gs_startdate'){
				var endDateText = $('#gs_enddate').val(); 
				if(date != endDateText.substr(0, splitIndex)){ 
					$('#gs_enddate').val(date + '23:59:59');						
				} else {
					var endTime = endDateText.substr(splitIndex).replace(/:/g, '');
					if(time > endTime){
						var defaultStartDate = date + '00:00:00';
						alert('종료날짜 이후의 시작날짜는 선택할 수 없습니다.\n\n' + defaultStartDate + '시로 자동설정됩니다.');
						$(this).timepicker('setTime', new Date(defaultStartDate));
					}
				}
			} else if(id == 'gs_enddate'){
				var startDateText = $('#gs_startdate').val();
				if(date != startDateText.substr(0, splitIndex)){
					$('#gs_startdate').val(date + '00:00:00');						
				} else {
					var startTime = startDateText.substr(splitIndex).replace(/:/g, '');
					if(time < startTime){
						var defaultEndDate = date + ' ' + '23:59:59';
						alert('시작날짜 이전의 종료날짜는 선택할 수 없습니다.\n\n' + defaultEndDate + '시로 자동설정됩니다.');
						$(this).timepicker('setTime', new Date(defaultEndDate));
					}
				}
			}
		},
		showOn : 'focus',
		onClose : function(){
			$('#list').trigger('triggerToolbar');
		}
	});
}

function fixSearchOperators() {
	var $grid = $("#list"), columns = $grid.jqGrid('getGridParam',
			'colModel'), filterToolbar = $($grid[0].grid.hDiv).find(
			"tr.ui-search-toolbar");

	filterToolbar
	.find("th")
	.each(
		function(index) {
			var $searchOper = $(this).find(".ui-search-oper");
			if (!(columns[index].searchoptions && columns[index].searchoptions.searchOperators)) {
				$searchOper.hide();
			}
		});
}

function addFileterToolbar() {
	$('#list').jqGrid('filterToolbar', {
		defaultSearch : 'cn',
		stringResult : true,
		ignoreCase : true,
		searchOperators : false
	});
}

function addExcelDownload() {
	$('#list').navButtonAdd('#pager', {
		buttonicon : "ui-icon-pencil",
		title : "Excel",
		caption : "Excel",
		position : "last",
		onClickButton : function() {
			$("#list").jqGrid("exportToExcel", {
				includeLabels : true,
				includeGroupHeader : false,
				includeFooter : false,
				fileName : "list.xlsx",
			})
		}
	});
}

function chkPwd(str){
	var pw = str;
	var num = pw.search(/[0-9]/g);
	var eng = pw.search(/[a-z]/ig);
	var spe = pw.search(/[`~!@@#$%^&*|\\\'\";:\/?]/gi);

	if(pw.length < 8 || pw.length > 20)
	{
		return [false,"비밀번호 - 8자리 ~ 20자리 이내로 입력해주세요."];
	}

	if(pw.search(/\s/) != -1)
	{
		return [false,"비밀번호 -  공백업이 입력해주세요."];
	} 
	
	if(num < 0 || eng < 0 || spe < 0 )
	{
		return [false,"비밀번호 - 영문,숫자, 특수문자를 혼합하여 입력해주세요."];
	}
	 
	if(document.getElementById("password").value != document.getElementById("password2").value)
	{
		return [false,"위 아래 비밀번호의 값이 다릅니다"];
	}

	return [true,""];
}

function errorOnLoad(request, status, error) {
	alert("DB에서 데이터를 불러오지 못했습니다")
	alert("code:" + request.status + "\n" + "message:" + request.responseText + "\n" + "error:" + error);
}; 	


function initGrid() {
	$(".jqgrow", "#list").dblclick('dblclick', function(){
		var grid = $("#list");
		var rowKey = grid.getGridParam("selrow");
		
		if (rowKey) {
			viewDialog.recreateForm = true;
			grid.viewGridRow(rowKey,viewDialog);
		} else {
			alert("No rows are selected");
		}
	});

	$(".jqgrow", "#list").contextMenu('contextMenu', {
           bindings: {
               'edit': function (t) {
                   editRow();
               },
               'add': function (t) {
                   addRow();
               },
               'del': function (t) {
                   delRow();
               },
               'view': function (t) {
                   viewRow();
               }
           },
           onContextMenu: function (event, menu) {
               var rowId = $(event.target).parent("tr").attr("id");
               $("#list").setSelection(rowId);
               return true;
           }
       });
          
	function addRow() {
	    $("#list").editGridRow("new", createDialog);
	}
	
	function editRow() {
	    var grid = $("#list");
	    var rowKey = grid.getGridParam("selrow");
	    if (rowKey) {
	        grid.editGridRow(rowKey, updateDialog);
	    }
	    else {
	        alert("No rows are selected");
	    }
	}
	
	function delRow() {
	    var grid = $("#list");
	    var rowKey = grid.getGridParam("selrow");
	    if (rowKey) {
	        grid.delGridRow(rowKey,deleteDialog);
	    }
	    else {
	        alert("No rows are selected");
	    }
	}
	
	function viewRow() {
	    var grid = $("#list");
	    var rowKey = grid.getGridParam("selrow");
	    if (rowKey) {
	        grid.viewGridRow(rowKey, viewDialog);
	    }
	    else {
	        alert("No rows are selected");
	    }
	}           
};

var autoRefreshInterval, selectValue;

function tableRefresh(){
	//$('#list').setGridParam({datatype: 'json', page:1}).trigger('reloadGrid');
	$('#list').setGridParam({datatype: 'json'}).trigger('triggerToolbar');
	if($('#gview_list span').text().trim() != 'Translog'){
		$('#list').jqGrid().trigger('clearToolbar');
	}
}

function setRefreshTime(sec, func){
	removeAutoRefresh();
	if(sec == 0) { return; }
	autoRefreshInterval = setInterval(func, sec*1000);
}

function removeAutoRefresh(){
	clearInterval(autoRefreshInterval);
}

function sortByKey(obj, key, order){
	var returnValue;
	if(order == 'asc') {
		returnValue = obj.sort(function(a, b){
			return a[key] < b[key] ? -1 : a[key] > b[key] ? 1 : 0;
		});
	} else {
		returnValue = obj.sort(function(a, b){
			return a[key] > b[key] ? -1 : a[key] < b[key] ? 1 : 0;
		});
	}
	return returnValue;
}

$(window).bind('pageshow', function(e){
	selectValue = $('#divTableRefresh select').val();
	 
	$('#divTableRefresh select, #divDetailRefresh select').change(function(){
		var parentDivId = $(this).parent().attr('id');
		var refreshTime = $(this).val();
		refreshTime == 0 ?
			removeAutoRefresh() : setRefreshTime(refreshTime, (parentDivId == 'divDetailRefresh' ? detailRefresh : tableRefresh));
	});
	
	$('#btnTableRefresh').on('click', function(){
		tableRefresh();
	});
});

</Script>

