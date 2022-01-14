<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<%@ include file="/WEB-INF/jsp/head/head.jsp"%>
</head>
<body>
	<div id="main_container">

		<!-- start of body-->

		<div class="header">
			<%@ include file="/WEB-INF/jsp/header/header.jsp"%>
		</div>

		<div class="main_content">

			<div class="menu">
				<%@ include file="/WEB-INF/jsp/menu/menuexpired.jsp"%>
			</div>

			<div class="center_content">

				<div class="left_content">
					<%@ include file="/WEB-INF/jsp/left/left-passwordexpired.jsp"%>
				</div>

				<div class="right_content">
					<!-- start of right content-->


					<h2>Password - 변경하지 않으면 어떤 메뉴도 접근할 수 없습니다</h2>
					<table id="list">
					</table>
					<div id="pager"></div>
					<%@ include file="/WEB-INF/jsp/menu/gridmenuonlyedit.jsp"%>


					<!-- end of right content-->
				</div>


			</div>

			<!-- do not delete this div:clear -->
			<div class="clear"></div>


		</div>


		<div class="footer">
			<%@ include file="/WEB-INF/jsp/footer/footer.jsp"%>
		</div>

		<!-- end of body-->
	</div>



<script type="text/javascript"> 


function chkPwd(str){

	 var pw = str;

	 var num = pw.search(/[0-9]/g);

	 var eng = pw.search(/[a-z]/ig);

	 var spe = pw.search(/[`~!@@#$%^&*|₩₩₩'₩";:₩/?]/gi);

	 

	 if(pw.length < 8 || pw.length > 20)
	 {
	  return [false,"비밀번호 - 8자리 ~ 20자리 이내로 입력해주세요."];
	 }

	 if(pw.search(/₩s/) != -1)
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
</script>
	
<script type="text/javascript">

var createDialog = {}
	
var updateDialog = {
		closeAfterAdd: true,
		closeAfterEdit: true,
		modal: true,		
		width: 400,
		beforeInitData: function(formid) {
			 $("#list").jqGrid('setColProp','seq',{editable:true,editoptions:{readonly:true},editrules:{required:true}});
			 $("#list").jqGrid('setColProp','username',{editable:true,editoptions:{readonly:true},editrules:{required:true}});
		     $("#list").jqGrid('setColProp','password',{editable:true,editrules:{custom:true,custom_func:chkPwd}
		                       ,edittype:"password",hidden : false});
		     $("#list").jqGrid('setColProp','password2',{editable:true,editrules:{custom:true,custom_func:chkPwd},
	             hidden:false,edittype:"password"});		     
		     $("#list").jqGrid('setColProp','fullname',{editable:true,editrules:{required:true},hidden: true});		     
		    },	
		afterShowForm: function () {	
		},
		onclickSubmit: function() {
		
		var rawData = new Object();
		rawData.username = document.getElementById("username").value;
		rawData.password = document.getElementById("password").value;		
		
		 //alert(JSON.stringify(rawData));	    
			
		jQuery.ajax({
			type:"PUT",
			url:"/rest/password/" + document.getElementById("seq").value,
			contentType: 'application/json',
			data: JSON.stringify(rawData),
			dataType:"json",
			success:function(){
				alert("password가 변경되었습니다. 다시 로그인 하세요");
				location.href = "/logout";
			},
		    error:function(request,status,error){
	            alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
	            location.href = "/admin/password";
	        }  
		});	
		}
	}
	
var deleteDialog = {}
</script>
  
	<script type="text/javascript">
		$(document)
				.ready(
						function() {
							jQuery("#list")
									.jqGrid(
											{
												url : '/rest/account',
												datatype : 'json',
												mtype : 'GET',
												colNames : [ 'seq', '사용자명', '비밀번호','비밀번호확인','설명','최종수정시간'],
												colModel : [ {
													name : 'seq',
													index : 'seq',
													sorttype: 'number',
													width : 100																										
												}, {
													name : 'username',
													index : 'username',
													width : 100																										
												}, {
													name : 'password',
													index : '',
													hidden : true,
													width : 50																										
												}, {
													name : 'password2',
													index : '',
													hidden : true,
													width : 50																										
												},{
													name : 'fullname',
													index : 'fullname',
													width : 100																										
												},{
													name : 'passworddate',
													index : 'passworddate',
													width : 100
												}
												],
												pager : '#pager',
												rowNum : 100,
												rowList : [ 20, 40, 60 ],
												sortname : 'seq',
												sortorder : 'desc',
												viewrecords : true,
												gridview : true,
												caption : 'Data',
												loadonce: true,
												autowidth: true, 
												shrinkToFit: true,
												emptyrecords: 'No Record',
												editurl :'clientArray',
												cellsubmit : 'clientArray',												
												height: 300,
												colMenu : true,
								                gridComplete: initGrid,
												
 												loadComplete: function() {
													var rowIds = $('#list').jqGrid('getDataIDs');
													for (i = 0; i < rowIds.length; i++) {//iterate over each row
														rowData = $('#list').jqGrid('getRowData', rowIds[i]);
														//set background style if ColValue === true\
														if (rowData['username'] != document.getElementById("authOjb").getAttribute('name')) {
															$('#list').jqGrid('setRowData', rowIds[i], false, {display:"none"});
														} //if
													}
												} 							

											



											});
							jQuery("#list").jqGrid('navGrid', '#pager', {
								add : false,
								edit : true,
								del : false,
								search : false,
								view: false
							},updateDialog
							 ,createDialog
							 ,deleteDialog);
						});
	</script>
</body>
</html>
