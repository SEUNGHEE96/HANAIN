package com.hanain.stock.model.dao;

import com.hanain.stock.model.dto.*;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;
import java.util.Map;

@Mapper
public interface StockDAO {

    List<StockDTO> getAllStock();
    List<StockDTO> getStockByMemberId(String memberId);
    List<StockDTO> getLikedStockByMemberId(String memberId);
    StockDTO findByName(String stockName);
    StockDTO findByIsin(String isin);
    List<StockDTO> stockListFindByName(String stockName);
    List<StockDTO> stockListFindByIsin(String isin);

    /* Ohlcv 테이블 */
    List<OhlcvDTO> getOHLCVByIsin(String isin);

    /* VALUATION 테이블 */
    List<ValuationDTO> getValuationByIsin(String isin);

    /* Fundamental 테이블 */
    List<FundamentalDTO> getFundamentalByIsin(String isin);

    /* 경쟁사 페이지 */
    List<StockChartDTO> getStocksBySector(String sector);
    List<Map<String, Object>> selectTags(String isin);
    List<StockChartDTO> selectStocksByTag(String tag);
    List<StockChartDTO> getStockChartByIsin(List<String> isins);
    StockDTO findByNameByWildCard(String stockName);

}
