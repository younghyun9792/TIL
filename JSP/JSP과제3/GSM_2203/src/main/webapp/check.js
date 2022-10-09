function chk_register(){
	if(document.register_frm.regist_month.value.length == 0){
		alert("수강월을 입력하지 않았습니다.");
		register_frm.regist_month.focus();
		return false;
	}
	else if(document.register_frm.c_no.value.length == 0){
		alert("회원번호가 입력되지 않았습니다.");
		register_frm.c_no.focus();
		return false;
	}
	else if(document.register_frm.class_price.value.length == 0){
		alert("수강료가 입력되지 않았습니다.");
		register_frm.class_price.focus();
		return false;
	}
	
	alert("수강신청이 정상적으로 완료되었습니다!");
	return true;
}


function chg_name(obj){
	var selected_index = obj.selectedIndex;
	var c_num = (obj[selected_index].id);
	document.register_frm.c_no.value = c_num;
}

function chg_class_name(obj){
	var selected_index = obj.selectedIndex;
	var class_price = obj[selected_index].id;
	if(document.register_frm.c_no.value.length != 0){
		if(document.register_frm.c_no.value >= 20000){
			document.register_frm.class_price.value=class_price/2;
		}
		else{
			document.register_frm.class_price.value=class_price;
		}
	}
}