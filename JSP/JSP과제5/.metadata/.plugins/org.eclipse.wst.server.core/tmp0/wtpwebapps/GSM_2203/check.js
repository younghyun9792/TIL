function chk_borrow(){
	if(document.borrow_frm.bor_no.value.length==0){
		alert("대여번호가 입력되지 않았습니다.");
		borrow_frm.bor_no.focus();
		return false;
	}
	else if(document.borrow_frm.m_name[1].selected == false && document.borrow_frm.m_name[2].selected == false && document.borrow_frm.m_name[3].selected == false && document.borrow_frm.m_name[4].selected == false && document.borrow_frm.m_name[5].selected == false){
		alert("고객이름이 선택되지 않았습니다.");
		borrow_frm.bor_name[0].focus();
		return false;
	}
	else if(document.borrow_frm.m_no.value.length==0){
		alert("고객번호가 입력되지 않았습니다.");
		borrow_frm.m_no.focus();
		return false;
	}
	else if(document.borrow_frm.job[0].checked == false && document.borrow_frm.job[1].checked == false && document.borrow_frm.job[2].checked == false){
		alert("직업이 선택되지 않았습니다.");
		borrow_frm.job[0].focus();
		return false;
	}
	else if(document.borrow_frm.bookname.value.length==0){
		alert("도서명이 입력되지 않았습니다.");
		borrow_frm.bookname.focus();
		return false;
	}
	else if(document.borrow_frm.bor_date.value.length==0){
		alert("대여날짜가 입력되지 않았습니다.");
		borrow_frm.bor_date.focus();
		return false;
	}
	alert("대여 완료");
}

function chk_select(obj){
	document.borrow_frm.m_no.value = document.borrow_frm.m_name[obj.selectedIndex].id;
}