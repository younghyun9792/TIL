function chk_insert(){
	if(document.insert_frm.sNo.value.length==0){
		alert("학번이 입력되지 않았습니다.");
		insert_frm.sNo.focus();
		return false;
	}
	else if(document.insert_frm.sName.value.length==0){
		alert("성명이 입력되지 않았습니다.");
		insert_frm.sName.focus();
		return false;
	}
	else if(document.insert_frm.kor.value.length==0){
		alert("국어점수가 입력되지 않았습니다.");
		insert_frm.kor.focus();
		return false;
	}
	else if(document.insert_frm.eng.value.length==0){
		alert("영어점수 입력되지 않았습니다.");
		insert_frm.eng.focus();
		return false;
	}
	else if(document.insert_frm.math.value.length==0){
		alert("수학점수 입력되지 않았습니다.");
		insert_frm.math.focus();
		return false;
	}
	else if(document.insert_frm.hist.value.length==0){
		alert("역사점수 입력되지 않았습니다.");
		insert_frm.hist.focus();
		return false;
	}
	alert("성적입력이 완료 되었습니다.");
	return true;
}