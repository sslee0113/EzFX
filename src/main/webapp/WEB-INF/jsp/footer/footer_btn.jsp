<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
						<div align="left" style="width:30%;float:left">
							<a id="excelBtn" href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-large-smartart" onclick="toExcel()" style="width:80px">엑셀</a>
							<a id="printBtn" href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-print" onclick="toPrint()" style="width:80px">인쇄</a>
						</div>
						<div align="right" style="width:70%;float:right">
							<a id="initBtn" href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-reload" onclick="initData()" style="width:80px">새로고침</a>
							<a id="saveBtn" href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-save" onclick="saveData()" style="width:80px">등록</a>
							<a id="editBtn" href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-edit" onclick="saveData()" style="width:80px">수정</a>
							<a id="cancelBtn" href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-cancel" onclick="cancelData()" style="width:80px">취소</a>
						</div>