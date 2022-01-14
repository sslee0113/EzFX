function initData(){
					
	formClear();

	targetUrl=defaultTargetUrl;
	restfulType = defaultRestfulType;

	setMaxLength();
	setTextBoxCss();
	setTextBoxDisable('all');
	setTextBoxEnable();
	setButtonDisable();
	setButtonEnable('saveBtn');

	setMenuPannel();
}

function viewData(){
	
	initData();

	var row = $('#dg').datagrid('getSelected');
	if (row){
		$('#fm').form('load',row);
		
		setButtonDisable();
//		setButtonEnable('newBtn');
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

/** 좌우 구조 **/
function setInputDivSizeType1(){
	
	var restHeight = 120; // HEAD와 FOOT 의 영역을 합친 길이
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
	
	var restHeight = 120; // HEAD와 FOOT 의 영역을 합친 길이
	var searchConditionDivHeight = 70; // 검색조건의 높이
	var mainEasyuiLayoutHeight = window.innerHeight - restHeight;
	var mainEasyuiLayoutWidth;
	var gridAccordionWidth = 'auto';
	var gridAccordionHeight = mainEasyuiLayoutHeight + defaultInputDivHeight - searchConditionDivHeight;
	var gridDivWidth = 'auto';
	var gridDivHeight;
	var inputDivHeight=defaultInputDivHeight;
	
	console.log("--------------------------------------");
	console.log("                       e:"+e);
	console.log("--------------------------------------");
	console.log("              restHeight:"+restHeight);
	console.log("searchConditionDivHeight:"+searchConditionDivHeight);
	console.log("       window.innerWidth:"+window.innerWidth);
	console.log("  mainEasyuiLayoutHeight:"+mainEasyuiLayoutHeight);
	console.log("     gridAccordionHeight:"+gridAccordionHeight);
	console.log("          inputDivHeight:"+inputDivHeight);
	
	if(e=='close'){

		// 브라우저 세로길이가 충분할 때
		if(mainEasyuiLayoutHeight>minHeight){

			gridDivHeight = mainEasyuiLayoutHeight - 160;

		}else{

		// 브라우저 세로길이가 최소 기준에 못 미칠 때는 스크롤이 생기더라도 기본 크기를 지정한다.
			mainEasyuiLayoutHeight 	= minHeight;	
			gridAccordionHeight 	= mainEasyuiLayoutHeight+defaultInputDivHeight-searchConditionDivHeight;
			gridDivHeight 			= mainEasyuiLayoutHeight-searchConditionDivHeight-90;
		}

	}else if(e=='open'){
	
		gridAccordionHeight 	= mainEasyuiLayoutHeight-searchConditionDivHeight;

		// 브라우저 세로길이가 충분할 때
		if(mainEasyuiLayoutHeight>minHeight){
			gridDivHeight 			= mainEasyuiLayoutHeight-defaultInputDivHeight-searchConditionDivHeight-50;	

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
	
	console.log("----------------------------------");
	console.log("mainEasyuiLayoutHeight:"+mainEasyuiLayoutHeight);
	console.log(" mainEasyuiLayoutWidth:"+mainEasyuiLayoutWidth);
	console.log("   gridAccordionHeight:"+gridAccordionHeight);
	console.log("         gridDivHeight:"+gridDivHeight);
	console.log("        inputDivHeight:"+inputDivHeight);
	console.log("----------------------------------");

	$('#main_easyui_layout').panel({ doSize:true, width:mainEasyuiLayoutWidth, height:mainEasyuiLayoutHeight});
	$('#main_easyui_layout').layout('resize', { width:mainEasyuiLayoutWidth, height:mainEasyuiLayoutHeight});
	$('#grid_div').panel({ doSize:true, width:'auto', height:gridDivHeight, title:"검색결과"});
	
	$('#menu_div').panel({doSize:true, height:'auto'});
	$('#contents_div').panel({doSize:true, width:'auto', height:'auto'});
	$('#grid_accordion').panel({doSize:true, width:'auto', height:gridAccordionHeight, title:""});
	$('#input_div').panel({doSize:true, height:inputDivHeight});
	
	if(e=='open'){
		$('#grid_accordion').accordion('select', '입력화면');
	}else{
		$('#grid_accordion').accordion('select', '검색결과');
	}
	
}

/** 상하 구조 고정 높이 **/
function setInputDivSizeType3(divName){
	
	var restHeight = 120; // HEAD와 FOOT 의 영역을 합친 길이
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
	
	divHeight = mainEasyuiLayoutHeight - 120;
	
	console.log("mainEasyuiLayoutHeight:"+mainEasyuiLayoutHeight);
	console.log("mainEasyuiLayoutWidth:"+mainEasyuiLayoutWidth);

	$('#main_easyui_layout').panel({ doSize:true, width:mainEasyuiLayoutWidth, height:mainEasyuiLayoutHeight});
	$('#main_easyui_layout').layout('resize', { width:mainEasyuiLayoutWidth, height:mainEasyuiLayoutHeight});

	console.log("divHeight:"+divHeight);
	if(divName=='grid_div'){
		$('#grid_div').panel({ doSize:true, width:'auto', height:divHeight, title:"검색결과"});
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
	
	// PANNEL 자동 선택
	if(pathName.indexOf('/exchange/')>0){
		$('#leftMenu').accordion('select', '환전');
	}else
	if(pathName.indexOf('/remittance/')>0){
		$('#leftMenu').accordion('select', '송금');
	}else
	if(pathName.indexOf('/bizcommon/')>0){
		$('#leftMenu').accordion('select', '업무공통');
	}else
	if(pathName.indexOf('/admin/')>0){
		$('#leftMenu').accordion('select', '계정관리');
	}
	
	// 메뉴 자동 선택
	if(pathName.indexOf('/account')>0){
		$('#menuAccount').linkbutton({ plain: false });
	}else
	// 통화관리
	if(pathName.indexOf('/currency')>0){
		$('#menuCurrency').linkbutton({ plain: false });
	}else
	// 영업점관리
	if(pathName.indexOf('/branch')>0){
		$('#menuBranch').linkbutton({ plain: false });
	}else
	// 국가관리
	if(pathName.indexOf('/country')>0){
		$('#menuCountry').linkbutton({ plain: false });
	}else
	// 고객관리
	if(pathName.indexOf('/customer')>0){
		$('#menuCustomer').linkbutton({ plain: false });
	}else
	// 환율고시
	if(pathName.indexOf('/frgnExchRateNotice')>0){
		$('#menuFrgnExchRateNotice').linkbutton({ plain: false });
	}else
	// 환율정보조회
	if(pathName.indexOf('/frgnExchRate')>0){
		$('#menuFrgnExchRate').linkbutton({ plain: false });
	}else
	// 외국통화매입
	if(pathName.indexOf('/exchangeBuy')>0){
		$('#menuExchangeBuy').linkbutton({ plain: false });
	}
	// 외국통화매도
	if(pathName.indexOf('/exchangeSell')>0){
		$('#menuExchangeSell').linkbutton({ plain: false });
	}
	// 환전목록조회
	if(pathName.indexOf('/exchangeList')>0){
		$('#menuExchangeList').linkbutton({ plain: false });
	}
	// 해외송금
	if(pathName.indexOf('/remittance')>0){
		$('#menuRemittance').linkbutton({ plain: false });
	}
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

function myformatter(date){
    var y = date.getFullYear();
    var m = date.getMonth()+1;
    var d = date.getDate();
    return y+'-'+(m<10?('0'+m):m)+'-'+(d<10?('0'+d):d);
}

function myparser(s){
    if (!s) return new Date();
    var ss = (s.split('-'));
    var y = parseInt(ss[0],10);
    var m = parseInt(ss[1],10);
    var d = parseInt(ss[2],10);
    if (!isNaN(y) && !isNaN(m) && !isNaN(d)){
        return new Date(y,m-1,d);
    } else {
        return new Date();
    }
}

// {message:"에러내용",code:"에러코드"} 형식의 responseText 에서 message 만 분리해내기 위해서
function getPureErrMsg(request){
	var msg = request.responseText;
	var msgList = msg.split(':');
	msgList = msgList[1].split(',');
	msg = msgList[0].replace(/\"/gi,'');
	
	return msg;
}

// 에러메시지 출력
function showErrMsg(msg){
	$.messager.show({    // show error message
		title: 'Error',
		msg: msg
	});
}

/** GRID FORMATTER **/
function formatDate(val,row){

	return getFormatDate(val);
}

function formatDecimal(val, row){
	
	return numberFormatFloat(val, 2);
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

// 거래주체
function formatTrMnbdPccd(val, row){

	if(val=='320'){
		return '320-개인기타';
	}else if(val=='620'){
		return '620-국가개인기타';
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

// String 으로 처리하면서 숫자에 , 와 소수점을 처리한다.
function numberFormatFloat(val) {

	if( isNaN(val) ) return val;
	
	var arr_number = val.toString().split('.');
	var number = arr_number[0];
 
	if(arr_number.length > 1) {
		var numberFloat = '.' + arr_number[1];
	}else{
		var numberFloat = '.00';
	}
 
	var gap = number.length % 3 || 3;
	var str = number.slice(0, gap);
 
	number = number.slice(gap);
	while (number) {
		str += ',' + number.slice(0, 3);
		number = number.slice(3);
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
