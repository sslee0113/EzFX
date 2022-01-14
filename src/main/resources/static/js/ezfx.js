function initData(){
					
	formClear();

	targetUrl=defaultTargetUrl;
	restfulType = defaultRestfulType;

	setMaxLength();
	setTextBoxCss();
	setTextBoxDisable('all');
	setTextBoxEnable();
	setButtonDisable();
	setButtonEnable('initBtn');
	setButtonEnable('saveBtn');

	setMenuPannel();
}

function viewData(){
	
	initData();

	var row = $('#dg').datagrid('getSelected');
	if (row){
		$('#fm').form('load',row);
		setButtonDisable();
		setButtonEnable('initBtn');
		setButtonEnable('editBtn');
		setButtonEnable('cancelBtn');
	}	
}

function setButtonDisable(){

//	$('#newBtn').linkbutton('disable');
	$('#initBtn').linkbutton('disable');
	$('#saveBtn').linkbutton('disable');
	$('#editBtn').linkbutton('disable');
	$('#cancelBtn').linkbutton('disable');
}
				
function setButtonEnable(btnName){

	/*
	if(btnName=='all' || btnName=='newBtn'){
		$('#newBtn').linkbutton('enable');
	}
	*/
	if(btnName=='all' || btnName=='initBtn'){
		$('#initBtn').linkbutton('enable');
	}
	if(btnName=='all' || btnName=='saveBtn'){
		$('#saveBtn').linkbutton('enable');
	}
	if(btnName=='all' || btnName=='editBtn'){
		$('#editBtn').linkbutton('enable');
	}
	if(btnName=='all' || btnName=='cancelBtn'){
		$('#cancelBtn').linkbutton('enable');
	}
}

function toExcel(){
	$('#dg').datagrid('toExcel','ezfxgrid.xls');
}

function toPrint(){
	$('#dg').datagrid('print','DataGrid');
}

function zipcodeWindowOpen(){
	$('#w').window('open');
}

function zipcodeWindowClose(){
	$('#w').window('close');
}

function setPagination(totalElements, pageNumber, pageSize){
	//PAGE SET
	// total : 전체 데이터 수
	// pageNumber : 현재 페이지 번호
	// pageSize : 페이지당 데이터 수
	// onSelectPage : 페이지 변경 이벤트 발생시 실행함
	//              { 
	//					pageNumber : 이동할 페이지번호
	//					pageSize : 선택된 페이지당 데이터 수
	//              }
	console.log('totalElements:'+totalElements);
	console.log('pageNumber:'+pageNumber);
	console.log('pageSize:'+pageSize);

	var pager = $('#dg').datagrid('getPager');
//	pageNumber = page+1;
	pageNumber++;
	pager.pagination({
		total:totalElements,
		pageNumber:pageNumber,
		pageSize:pageSize,
		onSelectPage:function(pageNumber, pageSize){
			//console.log('pageNumber:'+pageNumber);
			//console.log('pageSize'+pageSize);
			
			// 주어진 데이터로 재 검색
			searchData(pageNumber, pageSize);
		}
	});
	
	/** 
	 * 서버에서 페이징된 데이터를 가져와 그리드에 표시하고
	 * 페이지 정보를 임의로 표시하는 상황에서 ROWNUMBER 가 무조건 1로부터 시작되는 문제를
	 * EASYUI 에서 지원하지 않아서 임의로 값을 지정하는 방법은 다음과 같다.
	**/
	var rowNumber = (pageNumber-1) * pageSize + 1;
	$(".datagrid-cell-rownumber").each(function(){
		
		$(this).html(rowNumber++);
	});
}

function setPopupPagination(totalElements, pageNumber, pageSize){
	//PAGE SET
	// total : 전체 데이터 수
	// pageNumber : 현재 페이지 번호
	// pageSize : 페이지당 데이터 수
	// onSelectPage : 페이지 변경 이벤트 발생시 실행함
	//              { 
	//					pageNumber : 이동할 페이지번호
	//					pageSize : 선택된 페이지당 데이터 수
	//              }
	console.log('totalElements:'+totalElements);
	console.log('pageNumber:'+pageNumber);
	console.log('pageSize:'+pageSize);

	var pager = $('#zipcodeDg').datagrid('getPager');
//	pageNumber = page+1;
	pageNumber++;
	pager.pagination({
		total:totalElements,
		pageNumber:pageNumber,
		pageSize:pageSize,
		onSelectPage:function(pageNumber, pageSize){
			//console.log('pageNumber:'+pageNumber);
			//console.log('pageSize'+pageSize);
			
			// 주어진 데이터로 재 검색
			searchZipcodeData(pageNumber, pageSize);
		}
	});
	
	/** 
	 * 서버에서 페이징된 데이터를 가져와 그리드에 표시하고
	 * 페이지 정보를 임의로 표시하는 상황에서 ROWNUMBER 가 무조건 1로부터 시작되는 문제를
	 * EASYUI 에서 지원하지 않아서 임의로 값을 지정하는 방법은 다음과 같다.
	**/
	var rowNumber = (pageNumber-1) * pageSize + 1;
	$(".datagrid-cell-rownumber").each(function(){
		
		$(this).html(rowNumber++);
	});
}

/** 좌우 구조 **/
function setInputDivSizeType1(){
	
	var restHeight = 100; // HEAD와 FOOT 의 영역을 합친 길이
	var mainEasyuiLayoutHeight = window.innerHeight - restHeight;
	var mainEasyuiLayoutWidth = window.innerWidth;
	
	// 브라우저 가로길이가 최소 기준에 못 미칠 때는 스크롤이 생기더라도 기본 크기를 지정한다.
	if(mainEasyuiLayoutWidth<minWidth){
		mainEasyuiLayoutWidth = minWidth;
	}else{
	// 브라우저 가로길이가 충분할 때는 기본값으로 한다.
		mainEasyuiLayoutWidth = 'auto';
	}

	// 기본적인 브라우져 사이즈가 작을 때
	if(mainEasyuiLayoutHeight<minHeight){
		mainEasyuiLayoutHeight = minHeight;
	}
	
	console.log("mainEasyuiLayoutHeight:"+mainEasyuiLayoutHeight);
	console.log("mainEasyuiLayoutWidth:"+mainEasyuiLayoutWidth);

	$('#main_easyui_layout').panel({ doSize:true, width:mainEasyuiLayoutWidth, height:mainEasyuiLayoutHeight});
	$('#main_easyui_layout').layout('resize', { width:mainEasyuiLayoutWidth, height:mainEasyuiLayoutHeight});
}

/** 상하 구조 가변 높이 **/
function setInputDivSizeType2(e){
	
	var restHeight = 100; // HEAD와 FOOT 의 영역을 합친 길이
	var searchConditionDivHeight = 70; // 검색조건의 높이
	var mainEasyuiLayoutHeight = window.innerHeight - restHeight;
	var mainEasyuiLayoutWidth;
	var gridAccordionWidth = 'auto';
	var gridAccordionHeight = mainEasyuiLayoutHeight + defaultInputDivHeight - searchConditionDivHeight;
	var gridDivWidth = 'auto';
	var gridDivHeight;
	var inputDivHeight=defaultInputDivHeight;
	
	/*
	console.log("--------------------------------------");
	console.log("                       e:"+e);
	console.log("--------------------------------------");
	console.log("              restHeight:"+restHeight);
	console.log("searchConditionDivHeight:"+searchConditionDivHeight);
	console.log("       window.innerWidth:"+window.innerWidth);
	console.log("  mainEasyuiLayoutHeight:"+mainEasyuiLayoutHeight);
	console.log("     gridAccordionHeight:"+gridAccordionHeight);
	console.log("          inputDivHeight:"+inputDivHeight);
	*/
	
	// close : 그리드 바로 위의 검색라인이 1줄일 때 사용
	// close2 : 검색라인이 2줄일 때 사용 ex)fee.jsp 송금수수료 관리
	if(e=='close' || e=='close2'){

		// 브라우저 세로길이가 충분할 때
		if(mainEasyuiLayoutHeight>minHeight){

			gridDivHeight = mainEasyuiLayoutHeight - 185;

		}else{

		// 브라우저 세로길이가 최소 기준에 못 미칠 때는 스크롤이 생기더라도 기본 크기를 지정한다.
			mainEasyuiLayoutHeight 	= minHeight;	
			gridAccordionHeight 	= mainEasyuiLayoutHeight+defaultInputDivHeight-searchConditionDivHeight;
			gridDivHeight 			= mainEasyuiLayoutHeight-searchConditionDivHeight-90;
		}
		
		if(e=='close2'){
			gridDivHeight 			-= 20;

		}

	// open : 그리드 바로 위의 검색라인이 1줄일 때 사용
	// open2 : 검색라인이 2줄일 때 사용 ex)fee.jsp 송금수수료 관리
	}else if(e=='open' || e=='open2' || e=='openSubDg'){
	
		gridAccordionHeight 	= mainEasyuiLayoutHeight-searchConditionDivHeight;

		// 브라우저 세로길이가 충분할 때
		if(mainEasyuiLayoutHeight>minHeight){
			gridDivHeight 			= mainEasyuiLayoutHeight-defaultInputDivHeight-searchConditionDivHeight-60;	

		}else{

			mainEasyuiLayoutHeight	= minHeight;	
			gridDivHeight 			= mainEasyuiLayoutHeight-defaultInputDivHeight-searchConditionDivHeight-60;
			gridAccordionHeight 	+= defaultInputDivHeight;
			
			if(gridDivHeight<minGridDivHeight){
				gridDivHeight 			+= (minGridDivHeight-gridDivHeight);
				mainEasyuiLayoutHeight	+= gridDivHeight;
				gridAccordionHeight 	+= gridDivHeight;
			}
		}
		
	}
	
	// 브라우저 가로길이가 최소 기준에 못 미칠 때는 스크롤이 생기더라도 기본 크기를 지정한다.
	if(mainEasyuiLayoutWidth<minWidth){
		mainEasyuiLayoutWidth = minWidth;
	}else{
	// 브라우저 가로길이가 충분할 때는 기본값으로 한다.
		mainEasyuiLayoutWidth = 'auto';
	}
	
//	console.log("----------------------------------");
//	console.log("mainEasyuiLayoutHeight:"+mainEasyuiLayoutHeight);
//	console.log(" mainEasyuiLayoutWidth:"+mainEasyuiLayoutWidth);
//	console.log("   gridAccordionHeight:"+gridAccordionHeight);
//	console.log("         gridDivHeight:"+gridDivHeight);
//	console.log("        inputDivHeight:"+inputDivHeight);
//	console.log("----------------------------------");

	$('#main_easyui_layout').panel({ doSize:true, width:mainEasyuiLayoutWidth, height:mainEasyuiLayoutHeight});
	$('#main_easyui_layout').layout('resize', { width:mainEasyuiLayoutWidth, height:mainEasyuiLayoutHeight});
	$('#grid_div').panel({ doSize:true, width:'auto', height:gridDivHeight, title:"검색결과"});
	
	$('#menu_div').panel({doSize:true, height:'auto'});
//	$('#contents_div').panel({doSize:true, width:'auto', height:'auto'});
	$('#grid_accordion').panel({doSize:true, width:'auto', height:'auto', title:""});
	$('#input_div').panel({doSize:true, height:inputDivHeight});
	
	// 여기서부터는 그리드 사이즈를 지정하기 위해서 처리한다.
	if(e=='open' || e=='open2'){
		$('#grid_accordion').accordion('select', '입력화면');

		/*
		if(e=='open'){
//			gridDivHeight -= 35;
			gridDivHeight -= 45;
		}else{
			gridDivHeight -= 45;
		}
		*/
		gridDivHeight -= 45;
		$('#dg').datagrid({height:gridDivHeight});
	}else if(e=='openSubDg'){
		$('#grid_accordion').accordion('select', '상세내용');

		gridDivHeight -= 35;
		$('#dg').datagrid({height:gridDivHeight});
	}else{
	// close or close2 일 때

		$('#grid_accordion').accordion('select', '검색결과');

		if(e=='close2'){
//			gridDivHeight -= 10;
//			console.log('close2:'+gridDivHeight);
		}

		gridDivHeight -= 45;
		$('#dg').datagrid({height:gridDivHeight});
		
	}
		
}

/** 상하 구조 고정 높이 **/
function setInputDivSizeType3(divName){
	
	var restHeight = 100; // HEAD와 FOOT 의 영역을 합친 길이
	var mainEasyuiLayoutHeight = window.innerHeight - restHeight;
	var mainEasyuiLayoutWidth = window.innerWidth;
	var divHeight;
	
	// 브라우저 가로길이가 최소 기준에 못 미칠 때는 스크롤이 생기더라도 기본 크기를 지정한다.
	if(mainEasyuiLayoutWidth<minWidth){
		mainEasyuiLayoutWidth = minWidth;
	}else{
	// 브라우저 가로길이가 충분할 때는 기본값으로 한다.
		mainEasyuiLayoutWidth = 'auto';
	}

	// 기본적인 브라우져 사이즈가 작을 때
	if(mainEasyuiLayoutHeight<minHeight){
		mainEasyuiLayoutHeight = minHeight;
	}
	
	divHeight = mainEasyuiLayoutHeight - 130;
	
//	console.log("mainEasyuiLayoutHeight:"+mainEasyuiLayoutHeight);
//	console.log("mainEasyuiLayoutWidth:"+mainEasyuiLayoutWidth);

	$('#main_easyui_layout').panel({ doSize:true, width:mainEasyuiLayoutWidth, height:mainEasyuiLayoutHeight});
	$('#main_easyui_layout').layout('resize', { width:mainEasyuiLayoutWidth, height:mainEasyuiLayoutHeight});

//	console.log("divHeight:"+divHeight);
	if(divName=='dg'){
//		divHeight-=300;
//		$('#dg').panel({ doSize:true, width:'auto', height:divHeight});
	}
	else if(divName=='grid_div'){
		$('#grid_div').panel({ doSize:true, width:'auto', height:divHeight, title:"검색결과"});
		divHeight = divHeight - 52;
		$('#dg').datagrid({ height:divHeight });
	}
	else if(divName=='bsList'){
		$('#grid_div').panel({ doSize:true, width:'auto', height:divHeight, title:"검색결과"});
		divHeight = divHeight - 52 - 180;
		$('#dg').datagrid({ height:divHeight });
		divHeight = 180;
		$('#subdg').datagrid({ height:divHeight });
	}
	else if(divName=='mainBiz'){

		$('#main_easyui_layout').layout('resize', { width:mainEasyuiLayoutWidth, height:mainEasyuiLayoutHeight});
		
	}
	else if(divName=='total'){

		divHeight = divHeight - 10;
		$('#dg').datagrid({ height:divHeight });
		$('#subdg').datagrid({ height:divHeight });

	}else{
		$('#input_div').panel({ doSize:true, width:'auto', height:divHeight, title:"입력화면"});
	}
}

function getSelectedValue(dg, field){
	var dg = $(dg);
	var row = dg.datagrid('getSelected');
	if (!row){return undefined;}
	var fields = dg.datagrid('getColumnFields',true).concat(dg.datagrid('getColumnFields',false));
	if (typeof field == 'number'){
		return row[fields[field]];
	} else {
		return row[field];
	}
}

/** MENU **/
function setMenuPannel(){

	var pathName = window.location.pathname; 
	
	var url = pathName.split('\/');
	var urlSize = url.length;

	if(urlSize>0){
		pathName = url[urlSize-1];
		
		// exchangeBuy/CB****001 와 같은 형식의 URL 을 대응하기 위해서
//		console.log('urlSize:'+urlSize);
		if(urlSize>3){
//			console.log('urlSize-3:'+url[urlSize-3]);
//			console.log('urlSize-2:'+url[urlSize-2]);
			if(url[urlSize-2]=='exchangeBuy'){
				pathName = url[urlSize-2];
			}else
			if(url[urlSize-3]=='remittance' && url[urlSize-2]=='remittance'){
				pathName = url[urlSize-2];
			}
		}
	}
	
	console.log('pathName:'+pathName);
	
	/**
	 * menu 의 아이디는 'menu'+pathName 의 규칙으로 작성하고 pathName 의 첫글자는 대문자로 한다.
	 * 
	 * ex) account -> menuAccount 로 링크의 ID 를 지정한다.
	 */
	
	var upperName = pathName.toUpperCase();
	var idName = 'menu'+upperName.substring(0,1)+pathName.substring(1,pathName.length);
	
	console.log('idName:'+idName);
	
	// 메뉴 자동 선택
	$('#'+idName).linkbutton({ plain: false });

}


/** COMMON UTIL **/
function getToday(){
	var d = new Date();
	var year = d.getFullYear();
	var month = d.getMonth()+1;
	var day = d.getDate();
	var date = year+(month<10 ? '0' : '')+month+(day<10 ? '0' : '')+day;
	
	return date;
}

function getFormatDate(date){
	
	var str=date+'';
	
	if(str=='' || str.length!=8){
		str = getToday();
	}
	
	return str.substring(0,4)+'-'+str.substring(4,6)+'-'+str.substring(6,8);
}
// by sslee
function getFormatStartDayOfMonth(date){
	
	var str=date+'';
	
	if(str=='' || str.length!=8){
		str = getToday();
	}
	
	return str.substring(0,4)+'-'+str.substring(4,6)+'-01';
}

function getFormatTime(time){
	
	var str=time+'';
	
	if(str=='' || str.length!=6){
		return;
	}
	
	return str.substring(0,2)+':'+str.substring(2,4)+':'+str.substring(4,6);
}


function getFormatDatetime(datetime){
	
	var str=datetime+'';
	
	if(str=='' || str.length!=14){
		return;
	}
	return str.substring(0,4)+'-'+str.substring(4,6)+'-'+str.substring(6,8)+" "+ str.substring(8,10)+":"+str.substring(10,12)+":"+str.substring(12,14);
}

function myformatter(date){
    var y = date.getFullYear();
    var m = date.getMonth()+1;
    var d = date.getDate();
    return y+'-'+(m<10?('0'+m):m)+'-'+(d<10?('0'+d):d);
}

function myparser(s){
    if (!s) return new Date();
    
 //   console.log('myparser:'+s);
    
    if(s.indexOf('-')<=0 && s.length==8){
    	var yy = parseInt(s.substring(0,4),10);
    	var mm = parseInt(s.substring(4,6),10);
    	var dd = parseInt(s.substring(6,8),10);
    	
//		console.log('yy:'+yy+',mm:'+mm+',dd:'+dd);
		
    	return new Date(yy,mm-1,dd);
    }

    var ss = (s.split('-'));
    var y = parseInt(ss[0],10);
    var m = parseInt(ss[1],10);
    var d = parseInt(ss[2],10);
    
//    console.log('y:'+y+',m:'+m+',d:'+d);
    if (!isNaN(y) && !isNaN(m) && !isNaN(d)){
        return new Date(y,m-1,d);
    } else {
        return new Date();
    }
}

// {message:"에러내용",code:"에러코드"} 형식의 responseText 에서 message 만 분리해내기 위해서
function getPureErrMsg(request){
	
	console.log(request);
	
	var responseText = request.responseText;
	
	if(responseText != null && responseText != undefined){
		
		if(responseText.length > 1){
			if(responseText.substring(0, 1)!='{'){

				showErrMsg('<font color=red>세션</font>이 만료되었습니다. 자동으로 로그인 페이지로 이동합니다.');
				setTimeout(function(){window.location.href = '../error/sessionexpired'}, 3000);
				
				return;
			}
		}
		
	}
	var msg = JSON.parse(responseText);
	
	console.log(msg);
	console.log("message:"+msg.message);
	return msg.message;
	/*
	var msgList = msg.split(':');
	msgList = msgList[1].split(',');
	msg = msgList[0].replace(/\"/gi,'');
	
	return msg;
	*/
}

//정상 메시지 출력
function showInfMsg(msg){
	$.messager.show({    // show error message
		title: 'Info',
		timeout:1000,
		msg: msg
	});
}

// 에러메시지 출력
function showErrMsg(msg){
	$.messager.show({    // show error message
		title: 'Error',
		msg: msg
	});

}

// CHECK SESSION
function chkSession(request, url){

	var loginIdx = request.responseText.indexOf('/login');
	
	console.log('loginIdx:'+loginIdx);
	
	if(loginIdx>0){

		showErrMsg('<font color=red>세션</font>이 만료되었습니다. 자동으로 로그인 페이지로 이동합니다.');

		setTimeout(function(){window.location.href = url+'/error/sessionexpired'}, 3000);
		
		return false;
	}
	
	return true;
}

/** GRID FORMATTER **/
function formatDate(val,row){

	return getFormatDate(val);
}
function formatDatetime(val,row){
	return getFormatDatetime(val);
}

function formatTime(val,row){

	return getFormatTime(val);
}


function formatDecimal(val, row){
	
	return numberFormatFloat(val, 2);
}

function formatInteger(val, row){
	
	return numberFormatFloat(val, 0);
}

// 매입/매도 구분
function formatEfmDscd(val, row){
	
	if(val=='S'){
		return '매도';
	}else if(val=='B'){
		return '매입';
	}else{
		return val;
	}
}

// 거주성 구분
function formatAmtyDscd(val, row){
	
	if(val=='1'){
		return '거주자';
	}else if(val=='2'){
		return '비거주자';
	}else{
		return val;
	}
}

//거래주체
function formatTrMnbdPccd(val, row){

	if(val=='320'){
		return '320-개인기타';
	}else if(val=='620'){
		return '620-국가개인기타';
	}
}
//상태코드
function formatStacd(val, row){

	if(val=='0'){
		return '사용';
	}else if(val=='9'){
		return '삭제';
	}
}

// 사유코드
function formatIntdRscd(val, row){
	if(val=='111'){
		return '111-유학 및 훈련';
	}else if(val=='124'){
		return '124-업무상 여행';
	}else if(val=='125'){
		return '125-치료목적의 여행';
	}else if(val=='126'){
		return '126-관광,친지방문 등 기타일반여행';
	}else if(val=='127'){
		return '127-여행경비(환전상 등)';
	}else if(val=='128'){
		return '128-여행경비(신용카드)';
	}else if(val=='132'){
		return '132-여행 알선료';
	}else if(val=='141'){
		return '141-지참금';
	}else if(val=='190'){
		return '190-여행(100달러이하 소액거래)';
	}else{
		return val;
	}
}

// 업무구분
function formatBzTcd(val, row){
	if(val=='CS'){
		return '외국통화매매';
	}else if(val=='OR'){
		return '당발송금';
	}
}

// 처리구분
function formatPrcTcd(val, row){
	if(val=='1'){
		return '정상';
	}else if(val=='8'){
		return '취소대응';
	}else if(val=='9'){
		return '취소';
	}
}

// 계정과목명
function formatAcsjOputNm(val, row){

	if(row.acsjGrp == "2"){
		return '&nbsp;&nbsp;' + val.substring(2);
	}else if(row.acsjGrp == "3"){
		return '&nbsp;&nbsp;&nbsp;&nbsp;' + val.substring(4);
	}
	else if(row.acsjGrp == "4"){
		return '&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;' + val.substring(6);
	}
	else{
		return val;
	}
}


// 자산부채구분코드
function formatAstDbtTcd(val, row){
	if(val=='1'){
		return '자산';
	}else if(val=='2'){
		return '부채';
	}
	else if(val=='3'){
		return '수익';
	}
	else if(val=='4'){
		return '비용';
	}
	else if(val=='8'){
		return '각주';
	}
}

// 평가주체구분코드
function formatEvSbjTcd(val, row){
	if(val=='1'){
		return '패키지';
	}else if(val=='2'){
		return '계정계';
	}else if(val=='9'){
		return '기타';
	}else if(val=='0'){
		return '무';
	}
}

// 온라인구분코드
function formatOnlnTcd(val, row){
	if(val=='1'){
		return '온라인';
	}else if(val=='2'){
		return '비온라인';
	}else if(val=='3'){
		return '혼용';
	}else if(val=='0'){
		return '무';
	}
}

//상태구분코드
function formatWnFrTcd(val, row){
	if(val=='1'){
		return '외화';
	}else if(val=='0'){
		return '원화';
	}
}

// 상태구분코드
function formatStatTcd(val, row){
	if(val=='1'){
		return '정상';
	}else if(val=='9'){
		return '취소';
	}
}

//송금종류
function formatRmtKdcd(val, row){
	if(val=='1'){
		return '계좌송금';
	}else if(val=='2'){
		return '현금송금';
	}
}

// String 으로 처리하면서 숫자에 , 와 소수점을 처리한다.
function numberFormatFloat(val, decimal) {

if( isNaN(val) ) return val;
	
	if((val=='' || val==null) && decimal==0) return '0';

	if((val=='' || val==null) && decimal==2) return '0.00';

	var arr_number = val.toString().split('.');
	var number = arr_number[0];
	var numberFloat;
 
	if(arr_number.length > 1) {
		numberFloat = '.' + arr_number[1];
//		console.log("arr_number[1]:"+arr_number[1]);
		for(var i=0; i<decimal-arr_number[1].length; i++){
			numberFloat = numberFloat + '0';
		}
	}else{
		if(decimal == 0){
			numberFloat = '';
		}else{
			numberFloat = '.';
			for(var i=0; i<decimal; i++){
				numberFloat = numberFloat + '0';
			}
		}
	}
 
	var gap = number.length % 3 || 3;
	var str = number.slice(0, gap);
 
	number = number.slice(gap);
	while (number) {
		str += ',' + number.slice(0, 3);
		number = number.slice(3);
	}
	
	// -100 -> -,000 와 같이 나타나는 현상을 제거하기 위해서
	if(str.length>=2 && str.substring(0, 2)=='-,'){
		str = '-'+str.substring(2, str.length);
	}
	
	return str + numberFloat;
}

//format 함수를 추가해서 숫자에 , 를 채우는 방식
function formatDecimal_tmp(val, row){
	//숫자 타입에서 쓸 수 있도록 format() 함수 추가
	Number.prototype.format = function(){
	    if(this==0) return 0;
	 
	    var reg = /(^[+-]?\d+)(\d{3})/;
	    var n = (this + '');
	 
	    while (reg.test(n)) n = n.replace(reg, '$1' + ',' + '$2');
	 
	    return n;
	};
	 
	// 문자열 타입에서 쓸 수 있도록 format() 함수 추가
	String.prototype.format = function(){
	    var num = parseFloat(this);
	    if( isNaN(num) ) return "0";
	 
	    return num.format();
	};
	
	return val.format();
		
}

/**
 * 로그인 유저 정보 가져오기
 */
function getAccountInfo(url){
	
	var restfulType = 'GET';
	var pathName = window.location.pathname; 
	var accountInfo;
	var userId=" 사용자ID : ";
	var userName = " | 사용자이름 : ";
	var brno = " | 영업점 : ";
	var divText="";//"<img src='../../images/man.png'>";
	
	var getUrl = url + '/rest/userProfileInfo';
	
	userId = "사번 : "
	userNameStart = "(";
	brno = ") , 영업점 : ";
	
	jQuery.ajax({
		type:'get',
		url: getUrl,
		contentType: 'application/json',
		dataType:"json",
		success:function(data){
			
			divText += userId+data.userName;
			divText += userNameStart+data.fullName;
			divText += brno+data.brno+" ";
			divText += "<a href='#' class='logout' onclick=\"javascript:confirmLogout('"+url+"','"+data.userName+"')\">"+data.userName+"</a>";
			
			$('#accountInfoDiv').html(divText);
			
		},
		error:function(request,status,error){
			
			chkSession(request, url);

		}    		
	});	
	
}

/**
 * LOGOUT CONFIRM
 */
function confirmLogout(url, username){
	
	var rst = confirm("로그아웃 하시겠습니까?");
	if(rst == true){
		window.location.href=url+'/logout';
	}else{
		return;
	}

	return;
}

/**
 * SORTER
 */
function sorter(a,b){
	
	if (a < b){  
		return -1; 
	} else { 
		return 1; 
	} 
}

function onlyNumber(event){
	event = event || window.event;
	var keyID = (event.which) ? event.which : event.keyCode;
	if ( (keyID >= 48 && keyID <= 57) || (keyID >= 96 && keyID <= 105) || keyID == 8 || keyID == 46 || keyID == 37 || keyID == 39 ) 
		return;
	else
		return false;
}

function removeChar(event) {
	event = event || window.event;
	var keyID = (event.which) ? event.which : event.keyCode;
	if ( keyID == 8 || keyID == 46 || keyID == 37 || keyID == 39 ) 
		return;
	else
		event.target.value = event.target.value.replace(/[^0-9]/g, "");
}
