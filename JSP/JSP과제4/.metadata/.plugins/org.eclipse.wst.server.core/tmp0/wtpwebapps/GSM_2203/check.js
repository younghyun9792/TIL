function chk_vote(){
	if(document.vote_frm.V_JUMIN.value.length == 0){
		alert("주민번호가 입력되지 않았습니다!");
		vote_frm.V_JUMIN.focus();
		return false;
	}
	else if(document.vote_frm.V_NAME.value.length == 0){
		alert("성명이 입력되지 않았습니다!");
		vote_frm.V_NAME.focus();
		return false;
	}
	//else if(document.vote_frm.V_NAME.value.length == 0){
	//	alert("후보번호가 선택되지 않았습니다!");
	//	vote_frm.V_NAME.focus();
	//	return false;
	//}
	else if(document.vote_frm.V_TIME.value.length == 0){
		alert("투표시간이 입력되지 않았습니다!");
		vote_frm.V_TIME.focus();
		return false;
	}
	else if(document.vote_frm.V_AREA.value.length == 0){
		alert("투표장소가 입력되지 않았습니다!");
		vote_frm.V_AREA.focus();
		return false;
	}
	else if(document.vote_frm.V_CONFIRM[0].checked == false && document.vote_frm.V_CONFIRM[1].checked == false){
		alert("유권자확인이 선택되지 않았습니다!");
		vote_frm.V_NAME[0].focus();
		return false;
	}
	alert("투표하기 정보가 정상적으로 등록 되었습니다!");
	
	return true;
}

function chk_reset(){
	alert("정보를 지우고 처음부터 다시 입력합니다!");
}