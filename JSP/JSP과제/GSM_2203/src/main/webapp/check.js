function rere_order(){
	if(document.order_frm.custno.value.length == 0){
		alert("고객번호가 입력되지 않았습니다");	
		order_frm.custno.focus();
		return false;
	}
	else if(document.order_frm.custname.value.length == 0){
		alert("고객이름이 입력되지 않았습니다");	
		order_frm.custname.focus();
		return false;
	}
	else if(order_frm.menu[0].checked == false && order_frm.menu[1].checked == false && order_frm.menu[2].checked == false && order_frm.menu[3].checked == false && order_frm.menu[4].checked == false ){
		alert("메뉴가 입력되지 않았습니다");
		order_frm.menu[0].focus();
		return false;
	}
	else if(document.order_frm.custdate.value.length == 0){
		alert("날짜가 입력되지 않았습니다");	
		order_frm.custdate.focus();
		return false;
	}
	
	alert("주문 완료!");
	//document.order_frm.submit();
	return true;
}

function rere_reset(){
	alert("---처음부터 다시 시작-----");
	order_frm.custno.focus();
}

function rere_modify(){
	if(document.modify_frm.custno.value.length == 0){
		alert("고객번호가 입력되지 않았습니다");	
		order_frm.custno.focus();
		return false;
	}
	else if(document.modify_frm.custname.value.length == 0){
		alert("고객이름이 입력되지 않았습니다");	
		order_frm.custname.focus();
		return false;
	}
	else if(modify_frm.menu[0].checked == false && modify_frm.menu[1].checked == false && modify_frm.menu[2].checked == false && modify_frm.menu[3].checked == false && modify_frm.menu[4].checked == false ){
		alert("메뉴가 입력되지 않았습니다");
		order_frm.menu[0].focus();
		return false;
	}
	else if(document.modify_frm.custdate.value.length == 0){
		alert("날짜가 입력되지 않았습니다");	
		order_frm.custdate.focus();
		return false;
	}
	
	alert("수정 완료!");
	//document.modify_frm.submit();
	return true;
}