let currentIsin = '005930'; //삼성전자에서 시작
let currentAccountId = ''
let lineSeriesArray = []; // 이동평균선 담을 변수

function numberWithCommas(x) {
    return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
}

function removeCommas(str) {
    return str.replace(/,/g, '');
}

// 이동평균을 계산하는 함수
function movingAverage(data, numberOfPricePoints) {
    return data.map((row, index, total) => {
        const start = Math.max(0, index - numberOfPricePoints);
        const end = index;
        const subset = total.slice(start, end + 1);
        const sum = subset.reduce((acc, curr) => acc + curr.close, 0);
        return {
            time: row.time,
            value: sum / subset.length
        };
    });
}

// 사용자가 종목 검색 버튼을 클릭할 때 호출
function handleSearch() {
    var value = $('#search-box').val();
    currentIsin = value.replace(/\D/g, '');  // 숫자만 추출

    $('#isin').val(currentIsin);
    $('#isin2').val(currentIsin);

    // 이전에 추가한 선들을 제거합니다.
    lineSeriesArray.forEach(series => chart1.removeSeries(series));
    lineSeriesArray = []; // 배열을 초기화합니다.

    $.ajax({
        url: "/get-chart",
        type: "GET",
        contentType: "application/json",
        data: {
            'input': currentIsin
        },
        success: function (data) {
            const ohlcvList = JSON.parse(data);

            // 캔들 데이터 처리
            const candleData = ohlcvList.map((item) => ({
                close: item.close,
                high: item.high,
                low: item.low,
                open: item.open,
                time: new Date(item.regDate).toISOString().split('T')[0],
            }));
            candlestickSeries.setData(candleData);

            // 볼륨 데이터 처리
            const volumeData = ohlcvList.map((item, index) => {
                const todayVolume = item.volume;
                const yesterdayVolume = index > 0 ? ohlcvList[index - 1].volume : todayVolume;
                const color = todayVolume > yesterdayVolume ? 'rgba(255,82,82, 0.8)' : 'rgba(0, 150, 136, 0.8)';
                return {
                    time: new Date(item.regDate).toISOString().split('T')[0],
                    value: todayVolume,
                    color: color
                };
            });
            volumeSeries.setData(volumeData);

            // 20일 이동평균선을 계산합니다.
            const maData = movingAverage(candleData, 20);
            const maLineSeries = chart1.addLineSeries({
                color: 'rgba(226, 200, 48, 1)', // 이동평균선의 색상
                lineWidth: 2,
            });
            maLineSeries.setData(maData);
            lineSeriesArray.push(maLineSeries); // 이 선의 참조를 배열에 추가합니다.

            // 60일 이동평균선을 계산합니다.
            const maData2 = movingAverage(candleData, 60);
            const maLineSeries2 = chart1.addLineSeries({
                color: 'rgba(44, 213, 120, 1)', // 이동평균선의 색상
                lineWidth: 2,
            });
            maLineSeries2.setData(maData2);
            lineSeriesArray.push(maLineSeries2); // 이 선의 참조를 배열에 추가합니다.

            // 120일 이동평균선을 계산합니다.
            const maData3 = movingAverage(candleData, 120);
            const maLineSeries3 = chart1.addLineSeries({
                color: 'rgba(72, 194, 219, 1)', // 이동평균선의 색상
                lineWidth: 2,
            });
            maLineSeries3.setData(maData3);
            lineSeriesArray.push(maLineSeries3); // 이 선의 참조를 배열에 추가합니다.

            // ohlcvList의 마지막 값 표시
            const lastOhlcv = ohlcvList[ohlcvList.length - 1];
            const lastOhlcvText = `
            거래대금: ${lastOhlcv.volume},
            거래량: ${lastOhlcv.amount}
        `;
            $('#stockLastOhlcv').html(lastOhlcvText);
        },
        error: function () {
            alert("차트 그리기 실패");
        },
    });
    $.ajax({
        url: "/getStockInfo",
        type: "GET",
        contentType: "application/json",
        data: {
            'input': currentIsin
        },
        success: function (data) {
            console.log(data);
            if (data) { // Directly accessing data now
                let stockInfoHtml = `
                <div style="padding-left: 10px;">
                    <img src="../../resources/img/logo/${data.isin}.png" style="width: 40px; height: 40px; border-radius: 50%" >
                    <div style="display: inline-table; margin-left: 10px;">
                        <h4>${data.stockName}</h4>
                    <div>
                </div>
            `;
                $('#stockInfo').html(stockInfoHtml);
                $('#stockInfo2').html(stockInfoHtml);
            }
        }
    });
}

$(document).ready(function () {
    // 호가창의 td를 클릭했을 때
    $('#output').on('click', 'td:even', function () {
        // 클릭한 td의 값(가격)을 가져옵니다.
        var price = $(this).text().replace(/,/g, '');  // 콤마 제거

        // 해당 값을 매수 가격 필드에 설정합니다.
        $('.price').val(price);
    });

    function updateAccountInfo() {
        const accountNumber = $('#stockSelect').val();

        // First AJAX call
        $.ajax({
            url: '/getAccountInfo',
            method: 'GET',
            data: {'accountNumber': accountNumber},
            success: function (data) {
                currentAccountId = data.accountId;

                $('#accountId').val(currentAccountId);
                $('#accountId2').val(currentAccountId);

                if (data.cash) {
                    let formattedCash = numberWithCommas(data.cash);
                    $('#availableFunds').val(formattedCash);
                }

                // Second AJAX call inside the success of the first
                $.ajax({
                    url: '/getBalanceInfo',
                    method: 'GET',
                    data: {
                        'accountNumber': accountNumber,
                        'isin': currentIsin
                    },
                    success: function (data) {
                        if (data.quantity) {
                            let formattedNumber = numberWithCommas(data.quantity);
                            $('#availableFunds2').val(formattedNumber);
                        } else {
                            $('#availableFunds2').val("0");
                        }

                        // Only call the third AJAX if currentAccountId has a valid value
                        if (currentAccountId) {
                            $.ajax({
                                url: '/getTradeInfo',
                                method: 'GET',
                                data: {'accountId': currentAccountId},
                                success: function (data) {
                                    var tradeInfoHtml = "<table class=\"table table-sm table-centered mb-0\">\n" +
                                        "                                            <thead>\n" +
                                        "                                            <tr>\n" +
                                        "                                                <th>주식명</th>\n" +
                                        "                                                <th>유형</th>\n" +
                                        "                                                <th>가격</th>\n" +
                                        "                                                <th>수량</th>\n" +
                                        "                                            </tr>\n" +
                                        "                                            </thead>\n" +
                                        "                                            <tbody>\n";
                                    data.forEach(function (trade) {
                                        tradeInfoHtml += "<tr>\n" +
                                            "<td>" + trade.isin + "</td>\n" +
                                            "    <td>" + trade.type + "</td>\n" +
                                            "    <td>" + trade.price + " 원</td>\n" +
                                            "    <td><span class=\"badge bg-primary\">" + trade.quantity + " 주</span></td>\n" +
                                            "</tr>";
                                    });
                                    tradeInfoHtml += "</tbody>\n" +
                                        "</table>";
                                    $('#tradeInfo').html(tradeInfoHtml);
                                },
                                error: function () {
                                    alert('올바른 거래 내역이 반환되지 않았습니다.');
                                }
                            });
                        }
                    },
                    error: function () {
                        alert('올바른 잔고 정보가 반환되지 않았습니다.');
                    }
                });
            },
            error: function () {
                alert('올바른 계좌 정보가 반환되지 않았습니다.');
            }
        });
    }

    // Dropdown 변경 이벤트에 함수를 바인드합니다.
    $('#stockSelect').on('change', updateAccountInfo);

    // 페이지 로딩 시 함수를 즉시 호출합니다.
    updateAccountInfo();

    $("#buyForm").submit(function (e) {
        // buyPrice 필드에서 쉼표 제거
        var buyPrice = $("#buyPrice").val().replace(/,/g, '');
        $("#buyPrice").val(buyPrice);

        // orderQuantity 필드에서 쉼표 제거
        var orderQuantity = $("#orderQuantity").val().replace(/,/g, '');
        $("#orderQuantity").val(orderQuantity);

        // availableFunds 필드에서 쉼표 제거
        var availableFunds = $("#availableFunds").val().replace(/,/g, '');
        $("#availableFunds").val(availableFunds);

        // totalOrder 필드에서 쉼표 제거
        var totalOrder = $("#totalOrder").val().replace(/,/g, '');
        $("#totalOrder").val(totalOrder);

        // 값 검증 (옵션: 필요한 경우 추가로 검증 코드 작성)

        // 검증이 실패한 경우 (예: 입력 값이 숫자가 아닌 경우)
        // e.preventDefault();를 호출하여 폼 제출을 중지
    });
});

document.addEventListener('DOMContentLoaded', function () {

    function addButtonEventListener(id, percentage, calculationFunction) {
        document.getElementById(id).addEventListener('click', function () {
            calculationFunction(percentage);
        });
    }

    addButtonEventListener('10percent', 0.10, calculateBuyAmount);
    addButtonEventListener('25percent', 0.25, calculateBuyAmount);
    addButtonEventListener('50percent', 0.50, calculateBuyAmount);
    addButtonEventListener('100percent', 1.00, calculateBuyAmount);

    addButtonEventListener('10percent2', 0.10, calculateSellAmount);
    addButtonEventListener('25percent2', 0.25, calculateSellAmount);
    addButtonEventListener('50percent2', 0.50, calculateSellAmount);
    addButtonEventListener('100percent2', 1.00, calculateSellAmount);

    document.getElementById('orderQuantity').addEventListener('input', function () {
        updateTotalAmount('buyPrice', 'orderQuantity', 'totalOrder');
    });

    document.getElementById('orderQuantity2').addEventListener('input', function () {
        updateTotalAmount('buyPrice2', 'orderQuantity2', 'totalOrder2');
    });

    document.getElementById('orderQuantity').addEventListener('input', function () {
        checkBuyExceedsAvailableFunds();
    });

    document.getElementById('orderQuantity2').addEventListener('input', function () {
        checkSellExceedsAvailableShares();
    });

    function updateTotalAmount(priceId, quantityId, totalId) {
        let price = parseFloat(removeCommas(document.getElementById(priceId).value)) || 0;
        let quantity = parseFloat(removeCommas(document.getElementById(quantityId).value)) || 0;

        let totalAmount = price * quantity;
        document.getElementById(totalId).value = numberWithCommas(totalAmount.toFixed(0));
    }

    function calculateBuyAmount(percentage) {
        // 기존 calculateAmount 함수의 내용
        let availableFunds = parseFloat(removeCommas(document.getElementById('availableFunds').value)) || 0;
        let buyPrice = parseFloat(removeCommas(document.getElementById('buyPrice').value)) || 0;

        if (!availableFunds) {
            alert('올바른 계좌를 선택해주세요');
            return;
        }

        if (!buyPrice) {
            alert('가격을 선택해주세요');
            return;
        }

        let allocatedAmount = availableFunds * percentage;
        let possibleShares = Math.floor(allocatedAmount / buyPrice);
        let totalAmount = possibleShares * buyPrice;

        document.getElementById('totalOrder').value = numberWithCommas(totalAmount.toFixed(0));
        document.getElementById('orderQuantity').value = numberWithCommas(possibleShares);
    }

    function calculateSellAmount(percentage) {
        let availableShares = parseFloat(removeCommas(document.getElementById('availableFunds2').value)) || 0;
        let sellPrice = parseFloat(removeCommas(document.getElementById('buyPrice2').value)) || 0;

        if (!sellPrice) {
            alert('가격을 선택해주세요');
            return;
        }

        let sharesToSell = Math.floor(availableShares * percentage);
        let totalSellAmount = sharesToSell * sellPrice;

        document.getElementById('totalOrder2').value = numberWithCommas(totalSellAmount.toFixed(0));
        document.getElementById('orderQuantity2').value = numberWithCommas(sharesToSell);
    }

    function checkBuyExceedsAvailableFunds() {
        let availableFunds = parseFloat(removeCommas(document.getElementById('availableFunds').value)) || 0;
        let totalOrderAmount = parseFloat(removeCommas(document.getElementById('totalOrder').value)) || 0;

        if (totalOrderAmount > availableFunds) {
            alert('더 이상 구매할 수 없습니다');
            document.getElementById('orderQuantity').value = '';
            document.getElementById('totalOrder').value = '';
        }
    }

    function checkSellExceedsAvailableShares() {
        let availableShares = parseFloat(removeCommas(document.getElementById('availableFunds2').value)) || 0;
        let orderShares = parseFloat(removeCommas(document.getElementById('orderQuantity2').value)) || 0;

        if (orderShares > availableShares) {
            alert('최대 매도 수량을 초과하였습니다');
            document.getElementById('orderQuantity2').value = '';
            document.getElementById('totalOrder2').value = '';
        }
    }
});

var myChartElement1 = document.getElementById('myChart');
var chartWidth1 = myChartElement1.offsetWidth;
var chartHeight1 = myChartElement1.offsetHeight;

var chart1 = LightweightCharts.createChart(myChartElement1, {
    width: chartWidth1,
    height: chartHeight1,
    rightPriceScale: {
        visible: true,
        borderColor: 'rgba(197, 203, 206, 1)',
    },
    leftPriceScale: {
        visible: true,
        borderColor: 'rgba(197, 203, 206, 1)',
    },
    layout: {
        backgroundColor: '#ffffff',
        textColor: 'rgba(33, 56, 77, 1)',
    },
    grid: {
        horzLines: {
            color: '#F0F3FA',
        },
        vertLines: {
            color: '#F0F3FA',
        },
    },
    crosshair: {
        mode: LightweightCharts.CrosshairMode.Normal,
    },
    timeScale: {
        borderColor: 'rgba(197, 203, 206, 1)',
    },
    handleScroll: {
        vertTouchDrag: false,
    },
});


chart1.addLineSeries({
    color: 'rgba(4, 111, 232, 1)',
    lineWidth: 2,
}).setData([
    /*
    {time: {year: 2018, month: 9, day: 22}, value: 25.531816900940186},
    {time: {year: 2018, month: 12, day: 31}, value: 98.99348823473713}
     */
]);


const candlestickSeries = chart1.addCandlestickSeries({priceScaleId: 'left'});
candlestickSeries.setData([
    /*
    {
    close: 108.9974612905403,
    high: 121.20998259466148,
    low: 96.65376292551082,
    open: 104.5614412226746,
    time: {year: 2018, month: 9, day: 22}
    },
    {
        close: 110.46815600023501,
        high: 111.3650273696516,
        low: 82.65543461471314,
        open: 110.16538466099634,
        time: {year: 2018, month: 9, day: 23}
    }
     */
]);

/* --------------------------- 거래량 차트 데이터 --------------------------- */

var myChartElement2 = document.getElementById('volumeChart');
var chartWidth2 = myChartElement2.offsetWidth;
var chartHeight2 = myChartElement2.offsetHeight;

var chart2 = LightweightCharts.createChart(myChartElement2, {
    width: chartWidth2,
    height: chartHeight2,
    rightPriceScale: {
        scaleMargins: {
            top: 0.3,
            bottom: 0.25,
        },
        borderVisible: false,
    },
    layout: {
        background: {
            type: 'solid',
            color: '#FFFFFF',
        },
        textColor: '#d1d4dc',
    },
    /*
    grid: {
        vertLines: {
            color: 'rgba(42, 46, 57, 0)',
        },
        horzLines: {
            color: 'rgba(42, 46, 57, 0.6)',
        },
    },
    */
});

var areaSeries = chart2.addAreaSeries({
    topColor: 'rgba(38,198,218, 0.56)',
    bottomColor: 'rgba(38,198,218, 0.04)',
    lineColor: 'rgba(38,198,218, 1)',
    lineWidth: 2,
});

var volumeSeries = chart2.addHistogramSeries({
    color: '#26a69a',
    priceFormat: {
        type: 'volume',
    },
    priceScaleId: '',
});


chart2.priceScale('').applyOptions({
    /*
    scaleMargins: {
        top: 0.8,
        bottom: 0,
    },
    */
    autoScale: true,
});

/*
areaSeries.setData([
    { time: '2018-10-19', value: 54.90 },
    { time: '2019-05-28', value: 59.57 },
]);
 */

volumeSeries.setData([
    /*
    { time: '2018-10-19', value: 19103293.00, color: 'rgba(0, 150, 136, 0.8)' },
    { time: '2019-05-28', value: 3097125.00, color: 'rgba(0, 150, 136, 0.8)' }
     */
]);

const syncCharts = (chart1, chart2) => {
    let isSyncingChart1 = false;
    let isSyncingChart2 = false;

    const syncRange = (source, target, flagSetter) => {
        if (flagSetter()) return;

        const range = source.timeScale().getVisibleRange();
        if (range) {
            target.timeScale().setVisibleLogicalRange(range);
        }
    };

    chart1.timeScale().subscribeVisibleRangeChanged(() => {
        syncRange(chart1, chart2, () => {
            if (isSyncingChart1) return true;
            isSyncingChart2 = true;
            return false;
        });
        isSyncingChart2 = false;
    });

    chart2.timeScale().subscribeVisibleRangeChanged(() => {
        syncRange(chart2, chart1, () => {
            if (isSyncingChart2) return true;
            isSyncingChart1 = true;
            return false;
        });
        isSyncingChart1 = false;
    });
};

syncCharts(chart1, chart2);
