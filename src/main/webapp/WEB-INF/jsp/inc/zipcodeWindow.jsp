<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<div>
<div align="left" style="width:'auto';float:left">
	<a id="zipcodeWindow" href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-search" onclick="zipcodeWindowOpen()"></a>

</div>

<!--<div id="w" class="easyui-window" title="주소 찾기" data-options="iconCls:'icon-save'" style="width:665px;height:480px;padding:5px;">-->
<div id="w" class="easyui-dialog" title="주소 찾기" style="width:665px;height:470px;padding:5px;" data-options="closed:true,modal:true,border:'thin'">
	<div align="left" style="width:100%;float:left">
		<input id="searchZipcode" name="searchZipcode" class="easyui-textbox" label="우편번호" labelWidth="60px" labelAlign="right" style="width:108px" data-options="required:false" />
		<input id="searchProvince" name="searchProvince" class="easyui-textbox" label="시도" labelWidth="35px" labelAlign="right" style="width:105px" data-options="required:false" />
		<input id="searchRoadName" name="searchRoadName" class="easyui-textbox" label="도로명" labelWidth="48px" labelAlign="right" style="width:138px" data-options="required:false" />
		<input id="searchMainBuildingNo" name="searchMainBuildingNo" class="easyui-numberbox" label="건물번호본번" labelWidth="85px" labelAlign="right" style="width:117px" data-options="required:false" />
		<a href="#" class="easyui-linkbutton" iconCls="icon-search" onclick="searchZipcodeData()" style="width:30px;float:right"></a>
	</div>
	
	<!--
	<table id="zipcodeDg" class="easyui-datagrid" style="width:100%;padding:0px;height:400px"
		url="${pageContext.request.contextPath}/rest/zipcode/user?zipcode=&province=&roadName=&mainBuildingNo="
		method="get" toolbar="#toolbar" pagination="false"
		rownumbers="true" fitColumns="true" singleSelect="true">
	-->
	
	<table id="zipcodeDg" class="easyui-datagrid" style="width:100%;padding:0px;height:400px"
		view="scrollview"
		method="get" toolbar="#toolbar" pagination="true"
		rownumbers="true" fitColumns="true" singleSelect="true">
		<thead>
			<tr>
				<th field="zipcode" width="13%" sortable="false" ><center>우편번호</center></th>
				<th field="addr" width="87%" sortable="false" ><center>주소</center></th>
			</tr>
		</thead>
	</table>
</div>

	<script type="text/javascript">
		var totalElements;
	    var pageNumber;
    	var pageSize;
    	
    	function searchZipcodeData()
		{
			searchData(1,10);
		}
	
		function searchZipcodeData(page, size){
	
			var searchZipcode = $('#searchZipcode').val();
			var searchProvince = $('#searchProvince').val();
			var searchRoadName = $('#searchRoadName').val();
			var searchMainBuildingNo = $('#searchMainBuildingNo').val();
			var searchZipcodeLen = searchZipcode.length;
			var searchProvinceLen = searchProvince.length;
			var searchRoadNameLen = searchRoadName.length;
			var searchMainBuildingNoLen = searchMainBuildingNo.length;
			console.log("searchZipcode:"+searchZipcode);
			console.log("searchZipcode.length:"+searchZipcodeLen);
			console.log("searchProvince:"+searchProvince);
			console.log("searchProvince.length:"+searchProvinceLen);
			console.log("searchRoadName:"+searchRoadName);
			console.log("searchRoadName.length:"+searchRoadNameLen);
			console.log("searchMainBuildingNo:"+searchMainBuildingNo);
			console.log("searchMainBuildingNo.length:"+searchMainBuildingNoLen);
			
			if(searchZipcode=='' && searchProvince=='' && searchRoadName=='' && searchMainBuildingNo=='' ){
				showErrMsg('검색어를 입력하세요.');
				return;	
			}
			
			if(searchZipcode!=''){
			}
			else if(searchProvince == '' || searchRoadName == ''){
				$.messager.show({    // show error message
					title: 'Error',
					msg: '조회 결과가 없습니다. 입력값을 확인하세요'
				});
				return;
			}
			
			if(page==null || page==''){
				page = 1;
			}
			if(size==null || size==''){
				size = 20;
			}
			
			page--;
			
			var	url = '${pageContext.request.contextPath}/rest/searchListZipcodePopupPageable?zipcode='+ searchZipcode 
				+ '&province='+ searchProvince 
				+ '&roadName=' + searchRoadName 
				+ '&mainBuildingNo=' + searchMainBuildingNo
			    + '&page='+page+'&size='+size;
			
			pageNumber = page;
			console.log(url);
			
			jQuery.ajax({
				type:'GET',
				url:url,
				contentType: 'application/json',
				dataType:"json",
				success:function(data){
					// Page<?> 형태로 생성된 JSON 데이터로 부터 DATAGRID 에서 사용할 수 있는 형태로 변환
					var rawData = new Object();
					rawData.total = data.content.length;
					rawData.rows = data.content;
					// 변환된 JSON 형태를 그리드에 LOAD
					var dg = $('#zipcodeDg');
					dg.datagrid('loadData', rawData);
					
					totalElements = data.totalElements;
					pageSize = data.size;
					
					setPopupPagination(totalElements, pageNumber, pageSize);
					var rows = $('#zipcodeDg').datagrid('getRows').length; 
					if(rows==0){
						showErrMsg('조회 결과가 없습니다. 입력값을 확인하세요');
					}
				},
				onLoadError:function(){
					showErrMsg('조회 중 에러가 발생했습니다.');
				}
			});

		}

		function editZipcodeData(){
			var row = $('#zipcodeDg').datagrid('getSelected');
			
			console.log("xx:"+JSON.stringify(row));
			
			if (row){
				$('#fm').form('load',row);
			}
		}
		
		function setKeyDown(){
			var tZip = $('#searchZipcode');
			tZip.textbox('textbox').bind('keydown', function(e){
				if (e.keyCode == 13){   // when press ENTER key, accept the inputed value.
					searchZipcodeData();
				}
			});	
			
			var uZip = $('#searchProvince');
			uZip.textbox('textbox').bind('keydown', function(e){
				if (e.keyCode == 13){   // when press ENTER key, accept the inputed value.
					searchZipcodeData();
				}
			});	
		
			var wZip = $('#searchRoadName');
			wZip.textbox('textbox').bind('keydown', function(e){
				if (e.keyCode == 13){   // when press ENTER key, accept the inputed value.
					searchZipcodeData();
				}
			});
		
			var oZip = $('#searchMainBuildingNo');
			oZip.textbox('textbox').bind('keydown', function(e){
				if (e.keyCode == 13){   // when press ENTER key, accept the inputed value.
					searchZipcodeData();
				}
			});
		}
		
		function onLoadZipcode(){
			$('#zipcodeDg').datagrid({
				onDblClickRow: function(index,row){
					editZipcodeData();
					
					var addr1 = (row.addr);
					var addr2 = addr1.indexOf("<br>");
					var addr3 = addr1.substring(0, addr2);
					
					$('#zipCode').textbox('setValue', row.zipcode);
					$('#addr1').textbox('setValue', addr3);
					$('#addr2').textbox('setValue', "");
					
					/*
					// /rest/zipcode 일때
					
					var subbuildingno = (row.subBuildingNo != 0) ? "-" + row.subBuildingNo : "";
					var sublotno = (row.subLotNo != 0) ? "-" + row.subLotNo : "";

					if(row.buildingName != null){
						var buildingname1 = " (" + row.lawDongName + ", " + row.buildingName + ")";
					}
					else{
						buildingname1 = " (" + row.lawDongName + ")";
					}
					
					var buildingname2 = (row.buildingName != null) ? " (" + row.buildingName + ")" : "";
					
					$('#addr1').textbox('setValue', row.province + " " + row.county + " " + row.roadName + " " + row.mainBuildingNo + subbuildingno + buildingname1);
					$('#addr2').textbox('setValue', "");
					$('#addr2').textbox('setValue', row.province + " " + row.county + " " + row.lawDongName + " " + row.mainLotNo + sublotno + buildingname2);
					*/
					
					setTimeout(function(){setPopupPagination(totalElements, pageNumber, pageSize);}, 10);
					
					zipcodeWindowClose();
				}
			});
			
			// SET MAX
			$("#searchZipcode").textbox('textbox').attr('maxlength', 5);
			$("#searchProvince").textbox('textbox').attr('maxlength', 20);
			$("#searchRoadName").textbox('textbox').attr('maxlength', 80);
			$("#searchMainBuildingNo").textbox('textbox').attr('maxlength', 5);
					
			setKeyDown();
		}
		
		setTimeout(onLoadZipcode, 500);
	
/*
	$(document).ready(function(){
		
		// TEXTBOX에서 엔터 입력시 조회실행
		var t = $('#searchProvince');
		t.textbox('textbox').bind('keydown', function(e){
			if (e.keyCode == 13){   // when press ENTER key, accept the inputed value.
				searchData();
			}
		});	
	
		var u = $('#searchRoadName');
		u.textbox('textbox').bind('keydown', function(e){
			if (e.keyCode == 13){   // when press ENTER key, accept the inputed value.
				searchData();
			}
		});
	
		var u = $('#searchMainBuildingNo');
		u.textbox('textbox').bind('keydown', function(e){
			if (e.keyCode == 13){   // when press ENTER key, accept the inputed value.
				searchData();
			}
		});
		
		$('#zipcodeDg').datagrid({
			onDblClickRow: function(index,row){
				editData();
				zipcodeWindowClose();
				
				
			},
			onClickRow: function(index,row){
				editData();
			}
		})
		
		zipcodeWindowClose();
	})
	*/
	
	</script>
</div>
