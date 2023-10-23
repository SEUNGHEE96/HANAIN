package com.hanain.stock.controller;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.hanain.stock.model.dto.*;
import com.hanain.stock.service.StockService;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpSession;
import java.math.BigDecimal;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
public class StockController {

    private final StockService stockService;

    public StockController(StockService stockService) {
        this.stockService = stockService;
    }

    /**
     * 검색창 ajax
     *
     * @param input
     * @return
     */
    @ResponseBody
    @GetMapping(value = "/stock-searching")
    public ResponseEntity<List<StockDTO>> stockSearching(@RequestParam("input") String input) {
        List<StockDTO> stockList = stockService.searching(input);
        if (stockList != null && !stockList.isEmpty()) {
            return ResponseEntity.ok(stockList);
        } else {
            return ResponseEntity.notFound().build();
        }
    }

    /**
     * 캔들차트 ajax
     *
     * @param input
     * @return
     */
    @ResponseBody
    @GetMapping(value = "/get-chart")
    public ResponseEntity<String> getStockChartData(@RequestParam("input") String input, HttpSession session) {
        StockDTO stock = stockService.getStockByInput(input);
        session.setAttribute("currentStock", stock);
        List<OhlcvDTO> ohlcvList = stockService.search(stock);
        ObjectMapper objectMapper = new ObjectMapper();
        String json;
        try {
            json = objectMapper.writeValueAsString(ohlcvList);
        } catch (JsonProcessingException e) {
            return new ResponseEntity<>("Error processing JSON", HttpStatus.INTERNAL_SERVER_ERROR);
        }
        return new ResponseEntity<>(json, HttpStatus.OK);
    }

    /**
     * 주식 정보 조회 -> 주주 제안 작성 폼의 오른쪽
     *
     * @param isin
     * @return
     */
    @ResponseBody
    @GetMapping(value = "/getStockInfo")
    public StockDTO getStockInfo(@RequestParam("input") String input) {
        StockDTO stock = stockService.getStockByInput(input);
        return stock;
    }

    /* --------------------------------------- 기업정보 ---------------------------------*/
    @GetMapping("/stockinfo")
    public ModelAndView stockInfo() {
        ModelAndView mv = new ModelAndView("/stock/stockinfo");
        return mv;
    }

    @GetMapping("/get-all-stock-info")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> getAllStockInfo(@RequestParam("input") String input) {
        Map<String, Object> response = new HashMap<>();
        try {
            StockDTO stock = stockService.getStockByInput(input);
            List<OhlcvDTO> ohlcvList = stockService.getOHLCVByIsin(input);
            List<ValuationDTO> valuationList = stockService.getValuationByIsin(input);
            List<FundamentalDTO> fundamentalList = stockService.getFundamentalByIsin(input);

            response.put("stock", stock);
            response.put("ohlcvList", ohlcvList);
            response.put("valuationList", valuationList);
            response.put("fundamentalList", fundamentalList);
            for (FundamentalDTO fu : fundamentalList) {
                if (fu.getRegDate().substring(0, 4).equals("2023") && fu.getItem().equals("자산")) {
                    fu.setValue(fu.getValue().divide(new BigDecimal(4)));
                }
            }
            // 경쟁사 탭
            List<StockChartDTO> stockChartList = stockService.getStocksBySector(input);
            response.put("stockChartList", stockChartList);
            List<Map<String, Object>> tags = stockService.selectTags(input);
            response.put("tags", tags);
            return ResponseEntity.ok(response);
        } catch (Exception e) {
            // 에러 처리
            response.put("error", e.getMessage());
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(response);
        }
    }

    // 경쟁사 탭
    @PostMapping("/get-taged-stock")
    @ResponseBody
    public List<StockChartDTO> getTagedStock(@RequestBody List<String> isinList) {
        List<StockChartDTO> stockDataList = stockService.getStockChartByIsin(isinList);
        return stockDataList;
    }

    @PostMapping("/get-tagId")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> handleTagId(@RequestParam("tagId") String tagId) {
       try {
            Map<String, Object> response = new HashMap<>();

            List<StockChartDTO> selectStocksByTag = stockService.selectStocksByTag(tagId);
            response.put("selectStocksByTag", selectStocksByTag);
            return ResponseEntity.ok(response);
        } catch (Exception e) {
            // 에러 처리
            Map<String, Object> errorResponse = new HashMap<>();
            errorResponse.put("error", "Error handling tagId: " + e.getMessage());
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(errorResponse);
        }
    }

}