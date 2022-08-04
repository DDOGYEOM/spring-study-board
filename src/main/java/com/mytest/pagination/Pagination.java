package com.mytest.pagination;

public class Pagination {
	private int pageSize = 10;
	private int blockSize = 5;

	private int curPage = 1;
	private int curBlock = 1;

	private int totalListCnt;
	private int totalPageCnt;
	private int totalBlockCnt;

	private int startPage = 1;
	private int endPage = 1;

	private int startIndex = 0;

	private int prevBlock;
	private int nextBlock;

	public int getPageSize() {
		return pageSize;
	}

	public void setPageSize(int pageSize) {
		this.pageSize = pageSize;
	}

	public int getBlockSize() {
		return blockSize;
	}

	public void setBlockSize(int blockSize) {
		this.blockSize = blockSize;
	}

	public int getCurPage() {
		return curPage;
	}

	public void setCurPage(int curPage) {
		this.curPage = curPage;
	}

	public int getCurBlock() {
		return curBlock;
	}

	public void setCurBlock(int curBlock) {
		this.curBlock = curBlock;
	}

	public int getTotalListCnt() {
		return totalListCnt;
	}

	public void setTotalListCnt(int totalListCnt) {
		this.totalListCnt = totalListCnt;
	}

	public int getTotalPageCnt() {
		return totalPageCnt;
	}

	public void setTotalPageCnt(int totalPageCnt) {
		this.totalPageCnt = totalPageCnt;
	}

	public int getTotalBlockCnt() {
		return totalBlockCnt;
	}

	public void setTotalBlockCnt(int totalBlockCnt) {
		this.totalBlockCnt = totalBlockCnt;
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

	public int getStartIndex() {
		return startIndex;
	}

	public void setStartIndex(int startIndex) {
		this.startIndex = startIndex;
	}

	public int getPrevBlock() {
		return prevBlock;
	}

	public void setPrevBlock(int prevBlock) {
		this.prevBlock = prevBlock;
	}

	public int getNextBlock() {
		return nextBlock;
	}

	public void setNextBlock(int nextBlock) {
		this.nextBlock = nextBlock;
	}

	public Pagination(int totalListCnt, int page) {
		setTotalListCnt(totalListCnt);
		setTotalPageCnt((int) Math.ceil((totalListCnt * 1.0) / pageSize));
		setTotalBlockCnt((int) Math.ceil((totalPageCnt * 1.0) / blockSize));
		
		setCurPage(page);
		setCurBlock((int) Math.ceil((page * 1.0) / blockSize));
	
		setStartPage((curBlock - 1) * blockSize + 1);
		setEndPage(startPage + blockSize - 1);

		if (endPage > totalPageCnt) {
			this.endPage = totalPageCnt;
		}

		setPrevBlock((curBlock * blockSize) - blockSize);

		if (prevBlock < 1) {
			this.prevBlock = 1;
		}

		setNextBlock((curBlock * blockSize) + 1);

		if (nextBlock > totalPageCnt) {
			nextBlock = totalPageCnt;
		}

		setStartIndex((page - 1) * pageSize);
	}

	@Override
	public String toString() {
		return "Pagination [pageSize=" + pageSize + ", blockSize=" + blockSize + ", curPage=" + curPage + ", curBlock="
				+ curBlock + ", totalListCnt=" + totalListCnt + ", totalPageCnt=" + totalPageCnt + ", totalBlockCnt="
				+ totalBlockCnt + ", startPage=" + startPage + ", endPage=" + endPage + ", startIndex=" + startIndex
				+ ", prevBlock=" + prevBlock + ", nextBlock=" + nextBlock + "]";
	}
	
	
	

}
