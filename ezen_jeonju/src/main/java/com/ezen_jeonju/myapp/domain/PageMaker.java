package com.ezen_jeonju.myapp.domain;

import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;

import org.springframework.stereotype.Component;
import org.springframework.web.util.UriComponents;
import org.springframework.web.util.UriComponentsBuilder;

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
		
		//1.1에서 5까지 나타나게 설정
		//페이지번호/5 -> 1/5=0.2 -> 무조건 올림처리(ceil)하면 1*5==5
		//int형이라 소수점표기가 안되므로 double로 소수점표기 설정
		//끝 페이지 번호 = (현재 페이지 번호 / 화면에 보여질 페이지 번호의 갯수) * 화면에 보여질 페이지 번호의 갯수
		endPage = (int)(Math.ceil(scri.getPage()/(double)displayPageNum)*displayPageNum);	
		
		//2.endPage를 설정했으면 시작페이지도 설정
		//시작 페이지 번호 = (끝 페이지 번호 - 화면에 보여질 페이지 번호의 갯수) + 1
		startPage = (endPage-displayPageNum)+1;
		
		//3.실제 페이지 값을 뽑겠다
		int tempEndPage = (int)Math.ceil(totalCount/(double)scri.getPerPageNum());
		
		//4.설정endPage와 실제endPage를 비교한다
		if(endPage > tempEndPage) {
			endPage = tempEndPage;
		}
		
		//5.이전다음버튼 유무
		prev = (startPage == 1 ? false:true);
		next = (endPage*scri.getPerPageNum()>= totalCount ? false:true);
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

}