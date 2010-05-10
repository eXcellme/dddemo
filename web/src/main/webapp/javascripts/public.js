/*
 * 作者：
 * 制造日期：09-01
 * 联系方式：
 * 版本:V3.0
 * 内容概要: 公用的动态效果
*/

//按钮效果
var old=1;
function btn_change(i){
	old=i
}
function btn_change_over(i){
	var new_td11="btn1_"+i+"1";
	var new_td21="btn1_"+i+"2";
	var new_td31="btn1_"+i+"3";   
	eval("document.getElementById('"+new_td11+"')").className="left-over";
	eval("document.getElementById('"+new_td21+"')").className="middle-over";
	eval("document.getElementById('"+new_td31+"')").className="right-over"; 
 }
function btn_change_out(i){
	var new_td11="btn1_"+i+"1";
	var new_td21="btn1_"+i+"2";
	var new_td31="btn1_"+i+"3";   
	eval("document.getElementById('"+new_td11+"')").className="left-normal";
	eval("document.getElementById('"+new_td21+"')").className="middle-normal";
	eval("document.getElementById('"+new_td31+"')").className="right-normal"; 
 }

//全屏按钮
var f22=0;
function showFull_in(){
	if (f22==0) {
		parent.document.getElementById('fullscreen').href="../../css/index-full.css";
		document.getElementById('fullscreen').src="../../../images/public/ico16/ico_returnNormal.gif";
		f22=1;
	} else {
		parent.document.getElementById('fullscreen').href="../../css/index.css";
		document.getElementById('fullscreen').src="../../../images/public/ico16/ico_fullscreen.gif";
		f22=0;
	}
}

//隐藏日历
function myHidden(){
	  	 if(!window.calendar){
	  	 	  return;
	  	 }else{
	  	 	  window.calendar.hide();
	  	 }	  	 
	  }
	  
		function startDateFocus(dateObjStr){	
			 myHidden();
			 document.getElementById(dateObjStr).onclick();
			 document.getElementById(dateObjStr).focus();
		}