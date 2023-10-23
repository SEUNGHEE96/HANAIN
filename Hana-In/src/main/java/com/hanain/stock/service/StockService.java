package com.hanain.stock.service;

import com.hanain.stock.model.dao.StockDAO;
import com.hanain.stock.model.dto.*;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Arrays;
import java.util.List;
import java.util.Map;
import java.util.Optional;

@Service
public class StockService {

    @Autowired
    private StockDAO stockDAO;

    public List<StockDTO> getAllStock() {
        return stockDAO.getAllStock();
    }

    public List<StockDTO> getStockByMemberId(String memberId) {
        return stockDAO.getStockByMemberId(memberId);
    }

    public List<StockDTO> getLikedStockByMemberId(String memberId) {
        return stockDAO.getLikedStockByMemberId(memberId);
    }

    /**
     *  검색 중 : 종목 검색 중 실시간 비동기 Stock 객체 반환
     */
    public List<StockDTO> searching(String input) {
        List<StockDTO> stockList = null;
        try {
            stockList = stockDAO.stockListFindByName(input);
            // 이름 검색 결과 확인
            if (stockList.isEmpty()) {
                stockList = stockDAO.stockListFindByIsin(input);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return stockList;
    }

    /**
     * 종목 검색 기능 : 종목코드, 종목명 입력시 해당 주식 DTO를 반환
     * @param input
     * @return
     */
    public StockDTO getStockByInput(String input) {
        StockDTO stock = null;
        try {
            // 숫자만 포함된 경우 - isin으로 검색
            if (input.matches("^\\d+$")) {
                stock = stockDAO.findByIsin(input);
            }
            // 숫자와 글자 모두 포함 - 공백으로 분리 후 isin으로 검색
            else if (input.matches("^\\d+\\s+.+$")) {
                String[] parts = input.split("\\s+", 2); // 2를 추가하여 최대 2개의 문자열로 분리
                if (parts.length > 0) {
                    stock = stockDAO.findByIsin(parts[0]);
                }
            }
            // 글자만 포함된 경우 - 이름으로 검색
            else {
                stock = stockDAO.findByName(input);
            }
            System.out.println(stock.toString());
        } catch (Exception e) {
            e.printStackTrace();
        }
        return stock;
    }

    /**
     * 주가 정보 : StockDTO를 기준으로 ohlcv 데이터를 반환.
     */
    public List<OhlcvDTO> search(StockDTO stock) {
        List<OhlcvDTO> ohlcvList = stockDAO.getOHLCVByIsin(stock.getIsin());
        return ohlcvList;
    }

    /**
     * 주가 정보 : isin을 기준으로 ohlcv 데이터를 반환. -> 기업정보 탭에서 사용
     */
    public List<OhlcvDTO> getOHLCVByIsin(String isin) {
        List<OhlcvDTO> ohlcvList = stockDAO.getOHLCVByIsin(isin);
        return ohlcvList;
    }

    /**
     * 가치 정보 : isin을 기준으로 valuation 데이터를 반환. -> 기업정보 탭에서 사용
     */
    public List<ValuationDTO> getValuationByIsin(String isin) {
        List<ValuationDTO> valuationList = stockDAO.getValuationByIsin(isin);
        return valuationList;
    }

    /**
     * 재무 제표 : isin을 기준으로 fundamental 데이터를 반환. -> 기업정보 탭에서 사용
     */
    public List<FundamentalDTO> getFundamentalByIsin(String isin) {
        List<FundamentalDTO> fundamentalList = stockDAO.getFundamentalByIsin(isin);
        return fundamentalList;
    }

    /**
     * 경쟁사 페이지 : sector를 기준으로 stock 데이터를 반환. -> 경쟁사 탭에서 사용
     */
    public List<StockChartDTO> getStocksBySector(String sector) {
        List<StockChartDTO> stockCharList = stockDAO.getStocksBySector(sector);
        return stockCharList;
    }

    /**
     * 경쟁사 페이지 : isin을 기준으로 tag 데이터를 반환. -> 경쟁사 탭에서 사용
     */
    public List<Map<String, Object>> selectTags(String isin) {
        List<Map<String, Object>> tags = stockDAO.selectTags(isin);
        return tags;
    }

    /**
     * 경쟁사 페이지 : tag를 기준으로 stock 데이터를 반환. -> 경쟁사 탭에서 사용
     */
    public List<StockChartDTO> selectStocksByTag(String tag) {
        List<StockChartDTO> stockCharList = stockDAO.selectStocksByTag(tag);
        return stockCharList;
    }

    /**
     * 경쟁사 페이지 : isin을 기준으로 stock 데이터를 반환. -> 경쟁사 탭에서 사용
     */
    public List<StockChartDTO> getStockChartByIsin(List<String> isins) {
        List<StockChartDTO> stockCharList = stockDAO.getStockChartByIsin(isins);
        return stockCharList;
    }

    public StockDTO findByNameByWildCard(String stockName) {
        return stockDAO.findByNameByWildCard(stockName);
    }

}
