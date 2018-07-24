/*
Copyright 2018 Kim Doyoun

Version: 1.0.0 Timestamp: Wnd June 20 09:52:36 EDT 2018

*/
// 목록 페이징 
Paging = function(totalCnt, dataSize, pageSize, pageNo, token){
	totalCnt = parseInt(totalCnt);// 전체레코드수 
	dataSize = parseInt(dataSize); // 페이지당 보여줄 데이타수 
	pageSize = parseInt(pageSize); // 페이지 그룹 범위 1 2 3 5 6 7 8 9 10 
	pageNo = parseInt(pageNo); // 현재페이지 
	var html = new Array(); 
	
	if(totalCnt == 0){ 
		return "";
	}
	
	// 페이지 카운트 
	var pageCnt = totalCnt % dataSize;
	if(pageCnt == 0){ 
		pageCnt = parseInt(totalCnt / dataSize); 
	}else{ 
		pageCnt = parseInt(totalCnt / dataSize) + 1; 
	} 
	
	var pRCnt = parseInt(pageNo / pageSize); 
	if(pageNo % pageSize == 0){ 
		pRCnt = parseInt(pageNo / pageSize) - 1; 
	} 
	
    //처음으로
    html.push('<a href=javascript:' + token + '("');
	html.push('1'); 
	html.push('"); class="nav_paging_btn nav_paging_btn_fst">');
	html.push('<span class="blind">처음으로</span>'); 
	html.push("</a>"); 
	
	//이전 화살표
	if(pageNo > pageSize){ 
		var s2; 
		if(pageNo % pageSize == 0){ 
			s2 = pageNo - pageSize;
		}else{ 
			s2 = pageNo - pageNo % pageSize; 
		} 
		html.push('<a href=javascript:' + token + '("');
		html.push(s2); 
		html.push('"); class="nav_paging_btn nav_paging_btn_prev">');
		html.push('<span class="blind">이전으로</span>'); 
		html.push("</a>"); 
	}else{ 
		html.push('<a href="#" class="nav_paging_btn nav_paging_btn_prev">\n'); 
		html.push('<span class="blind">이전으로</span>'); 
		html.push('</a>'); 
	} 
	//paging Bar 
	for(var k=pRCnt * pageSize + 1;k<(pRCnt + 1)*pageSize + 1;k++){ 
		if(k == pageNo){
			html.push('<a href="#" class="nav_paging_num selected">'); 
			html.push('<span class="num">');
			html.push(k); 
			html.push('</span>');
			html.push('</a>'); 
		}else{ 
			html.push('<a href=javascript:' + token + '("'); 
			html.push(k); 
			html.push('"); class="nav_paging_num">');
			html.push('<span class="num">');
			html.push(k); 
			html.push('</span>');
			html.push('</a>'); 
		} 
		
		if(k == pageCnt){ 
			break; 
		}
	} 
	
	//다음 화살표 
	if(pageCnt > (pRCnt + 1) * pageSize){ 
		html.push('<a href=javascript:' + token + '("'); 
		html.push((pRCnt + 1)*pageSize+1); 
		html.push('"); class="nav_paging_btn nav_paging_btn_next">'); 
		html.push('<span class="blind">다음으로</span>'); 
		html.push('</a>'); 
	}else{ 
		html.push('<a href="#" class="nav_paging_btn nav_paging_btn_next">'); 
		html.push('<span class="blind">다음으로</span>'); 
		html.push('</a>'); 
	} 
	
	//마지막으로
    html.push('<a href=javascript:' + token + '("');
	html.push(pageCnt); 
	html.push('"); class="nav_paging_btn nav_paging_btn_lst">');
	html.push('<span class="blind">마지막으로</span>'); 
	html.push("</a>"); 
	
	return html.join("");
}

var goPaging_PagingView = function(cPage){
	//게시물을 가져오는 함수에 cPage값을 보내서 사용하세요.cPage는 현재 사용자가 클릭한 페이지값을 의미합니다. 
};

