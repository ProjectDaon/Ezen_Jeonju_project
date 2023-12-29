package com.ezen_jeonju.myapp.domain;

import org.springframework.stereotype.Component;

@Component		// PageMaker 가 bean으로 등록이 됨, import
//하단페이지 네비게이션에 필요한 변수들의 집합 데이터클래스
public class PageMaker {
	
	private int displayPageNum = 5;		//하단에 페이지목록번호
	private int startPage;				//목록의 시작번호
	private int endPage;				//목록의 끝번호
	private int totalCount;				//총 게시물 수 담는변수
	
	private boolean prev;				//이전버튼존재 유무변수
	private boolean next;				//다음버튼존재 유무변수
	
	private SearchCriteria scri;
	private Criteria cri;
	private ContentsSearchCriteria cscri;
	private ReviewCriteria rcri;
	
	public Criteria getCri() {
		return cri;
	}

	public void setCri(Criteria cri) {
		this.cri = cri;
	}

	public SearchCriteria getScri() {
		return scri;
	}

	public void setScri(SearchCriteria scri) {
		this.scri = scri;
	}

	public int getDisplayPageNum() {
		return displayPageNum;
	}

	public void setDisplayPageNum(int displayPageNum) {
		this.displayPageNum = displayPageNum;
	}

	public int getStartPage() {
		return startPage;
	}

	public void setStartPage(int startPage) {
		this.startPage = startPage;
	}

	public int getEndPage() {
		return endPage;
	}

	public void setEndPage(int endPage) {
		this.endPage = endPage;
	}

	public int getTotalCount() {
		return totalCount;
	}

	public void setTotalCount(int totalCount) {
		this.totalCount = totalCount;
		calcData();		//페이지목록개수를 나타내주기 위한 계산식
	}

	private void calcData() {
	    int perPageNum = 0;
	    int currentPage = 0;
	    
	    if(scri != null) {
	    	perPageNum = scri.getPerPageNum();
	    	currentPage = scri.getPage();
	    }else if(cscri != null) {
	    	perPageNum = cscri.getPerPageNum();
	    	currentPage = cscri.getPage();
	    }else if(rcri != null){
	    	perPageNum = rcri.getPerPageNum();
	    	currentPage = rcri.getPage();
	    }
	    
	    // 1. 기본적으로 1에서 10까지 나타나게 설정
	    endPage = (int) (Math.ceil(currentPage / (double) displayPageNum) * displayPageNum);

	    // 2. endPage를 설정했으면 시작페이지도 설정
	    startPage = (endPage - displayPageNum) + 1;

	    // 3. 실제 페이지 값을 뽑겠다
	    int tempEndPage = (int) Math.ceil(totalCount / (double) perPageNum);

	    // 4. 설정 endPage와 실제 endPage를 비교한다
	    if (endPage > tempEndPage) {
	        endPage = tempEndPage;
	    }

	    // 5. 이전 다음 버튼 유무
	    prev = (startPage == 1) ? false : true;
	    next = (endPage * perPageNum >= totalCount) ? false : true;
	}
	
	
	public boolean isPrev() {
		return prev;
	}

	public void setPrev(boolean prev) {
		this.prev = prev;
	}

	public boolean isNext() {
		return next;
	}

	public void setNext(boolean next) {
		this.next = next;
	}

	public ContentsSearchCriteria getCscri() {
		return cscri;
	}

	public void setCscri(ContentsSearchCriteria cscri) {
		this.cscri = cscri;
	}

	public ReviewCriteria getRcri() {
		return rcri;
	}

	public void setRcri(ReviewCriteria rcri) {
		this.rcri = rcri;
	}

}