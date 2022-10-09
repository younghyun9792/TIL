function chk_register(){
	
	
	if(document.register_frm.custname.value.length==0){
		alert("회원성명이 입력되지 않았습니다.");
		register_frm.custname.focus();
		return false;
	}
	else if(document.register_frm.phone.value.length==0){
		alert("회원전화가 입력되지 않았습니다.");
		register_frm.phone.focus();
		return false;
	}
	else if(document.register_frm.address.value.length==0){
		alert("회원주소가 입력되지 않았습니다.");
		register_frm.address.focus();
		return false;
	}
	else if(document.register_frm.joindate.value.length==0){
		alert("가입일자가 입력되지 않았습니다.");
		register_frm.joindate.focus();
		return false;
	}
	else if(document.register_frm.grade.value.length==0){
		alert("고객등급이 입력되지 않았습니다.");
		register_frm.grade.focus();
		return false;
	}
	else if(document.register_frm.city.value.length==0){
		alert("도시코드가 입력되지 않았습니다.");
		register_frm.city.focus();
		return false;
	}
	alert("회원등록이 완료 되었습니다.");
	return true;	
}

function chk_modify(){
	
	
	if(document.modify_frm.custname.value.length==0){
		alert("회원성명이 입력되지 않았습니다.");
		register_frm.custname.focus();
		return false;
	}
	else if(document.modify_frm.phone.value.length==0){
		alert("회원전화가 입력되지 않았습니다.");
		register_frm.phone.focus();
		return false;
	}
	else if(document.modify_frm.address.value.length==0){
		alert("회원주소가 입력되지 않았습니다.");
		register_frm.address.focus();
		return false;
	}
	else if(document.modify_frm.joindate.value.length==0){
		alert("가입일자가 입력되지 않았습니다.");
		register_frm.joindate.focus();
		return false;
	}
	else if(document.modify_frm.grade.value.length==0){
		alert("고객등급이 입력되지 않았습니다.");
		register_frm.grade.focus();
		return false;
	}
	else if(document.modify_frm.city.value.length==0){
		alert("도시코드가 입력되지 않았습니다.");
		register_frm.city.focus();
		return false;
	}
	alert("회원정보수정이 완료 되었습니다!");
	return true;	
}

function search() {
	window.location = 'list.jsp';
}