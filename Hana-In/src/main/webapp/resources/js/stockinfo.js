let myChart1, myChart2, myChart3, myChart4, myChart5, myChart6, myChart7;// 차트 인스턴스를 저장할 변수를 선언합니다.
var globalStockChartList = [];  // AJAX 호출로 받아온 stockChartList 데이터를 저장할 배열
var currentIsin = '005930';  // 현재 선택된 종목의 ISIN 값을 저장할 변수

$(document).ready(function () {
    // 페이지 로드 완료 시 '005930' 로드
    loadChartData('005930');

    // 주식호가 등록 버튼 처리
    document.getElementById("hokaregButton1").onclick = function () {
        handleSearch();
    }

    // li 태그 클릭 이벤트 처리
    $(".list-group").on("click", "li", function() {
        // 모든 li 태그에서 'selected-tag' 클래스를 제거
        $(this).siblings().removeClass("selected-tag");
        // 클릭된 li 태그에 'selected-tag' 클래스를 추가
        $(this).addClass("selected-tag");
    });

    sendSelectedStocks();

    // 관심 종목 버튼
    let liked = false; // 현재 '좋아요' 상태를 나타내는 변수
    $('#likeButton').on('click', function() {
        if (liked) {
            // 좋아요 취소 상태로 바꾸는 코드
            $(this).html('<i class="mdi mdi-heart-outline"></i>');
            liked = false;
        } else {
            // 좋아요 상태로 바꾸는 코드
            $(this).html('<i class="mdi mdi-heart me-1"></i> <span>Like</span>');
            liked = true;
        }
    });
});

// 사용자가 종목 검색 버튼을 클릭할 때 호출
function handleSearch() {
    var value = $('#search-box').val();
    var isin = value.replace(/\D/g, '');  // 숫자만 추출

    // 선택된 카드의 .selected 클래스를 제거하고, 그에 따른 버튼도 제거
    $('.clickable.selected').each(function() {
        var stockName = $(this).find('h5').text().trim();
        $(this).removeClass('selected');
        // 선택 해제된 카드의 기업명에 해당하는 버튼을 제거합니다.
        $(".col.d-flex").find("button:contains('" + stockName + "')").remove();
    });

    // 사용자가 입력한 ISIN으로 차트 데이터 로드
    loadChartData(isin);
    sendSelectedStocks();

    // 좋아요 버튼을 초기 상태로 설정
    $('#likeButton').html('<i class="mdi mdi-heart-outline"></i>');
}

function loadChartData(isin) {
    // 기존의 차트 인스턴스가 있다면 제거합니다.
    if (myChart1) myChart1.destroy();
    if (myChart2) myChart2.destroy();
    if (myChart3) myChart3.destroy();
    if (myChart4) myChart4.destroy();

    // 기존에 표시된 값을 초기화합니다.
    $('.custom-table .content').text('');
    document.getElementById('sales-title').innerText = '';
    document.getElementById('operating-profit-title').innerText = '';
    document.getElementById('net-profit-title').innerText = '';
    document.getElementById('assets-title').innerText = '';

    currentIsin = isin;
    $('#isin').val(currentIsin);

    var issuedShares = 0;

    $.ajax({
        url: "/get-all-stock-info",
        type: "GET",
        contentType: "application/json",
        data: {
            'input': currentIsin
        },
        // AJAX 호출이 성공했을 때의 콜백 함수 내부
        success: function (data) {
            if (data.error) {
                alert("데이터 그리기 실패: " + data.error);
                return;
            }

            let stock = data.stock;
            issuedShares = stock.issuedShares;
            let stockInfoHtml = `
                <div style="margin-bottom: 30px;">
                    <img src="../../resources/img/logo/${stock.isin}.png" style="width: 50px; height: 50px; border-radius: 50%; margin-top: 20px;" >
                    <div style="display: inline-table; margin-left: 10px;">
                        <h4>${stock.stockName}</h4>
                        <div style="color: grey; font-size: 0.8rem"> ${stock.isin} 코스피 </div>
                    <div>
                </div>
            `;
            $('#stockInfo').html(stockInfoHtml);

            // '산업 : stock.sector' 태그 추가
            var sectorTagHtml = `<li class="list-group-item active" data-sector="${stock.sector}">산업 : ${stock.sector}</li>`;
            $(".list-group").prepend(sectorTagHtml); // 태그 목록의 가장 위에 추가

            console.log(data.ohlcvList);
            console.log(data.valuationList);
            console.log(data.fundamentalList);
            console.log(data.stockCharList);

            // 재무정보 탭
            // Extract the needed information from the data
            let fundamentals = data.fundamentalList.filter((item) => item.regDate.startsWith('2022-12-31'));
            let latestOhlcv = data.ohlcvList[data.ohlcvList.length - 1];
            let dividendItem = fundamentals.find((item) => item.item === '배당금지급(-)');
            let dividend = dividendItem ? dividendItem.value : 'NaN';
            let latestClose = latestOhlcv.close;

            // Dividend Yield Calculation
            let dividendYield = Math.abs(dividend) / latestClose;

            // Inject the information into the table
            $('td:contains("매출액") .content').text((fundamentals.find((item) => item.item === '매출액').value || 0).toLocaleString());
            $('td:contains("영업이익") .content').text((fundamentals.find((item) => item.item === '영업이익').value || 0).toLocaleString());
            $('td:contains("당기순이익") .content').text((fundamentals.find((item) => item.item === '당기순이익').value || 0).toLocaleString());
            $('td:contains("자산") .content').text((fundamentals.find((item) => item.item === '자산').value || 0).toLocaleString());
            $('td:contains("부채") .content').text((fundamentals.find((item) => item.item === '부채').value || 0).toLocaleString());
            $('td:contains("자본") .content').text((fundamentals.find((item) => item.item === '자본').value || 0).toLocaleString());
            $('td:contains("배당수익률") .content').text(dividend === 'NaN' ? 'NaN' : (dividendYield.toFixed(2)).toLocaleString() + '%');
            $('td:contains("자본잉여금") .content').text((fundamentals.find((item) => item.item === '이익잉여금(결손금)').value || 0).toLocaleString());

            document.getElementById('sales-title').innerText += `: ${(fundamentals.find((item) => item.item === '매출액').value || 0).toLocaleString()} 억원`;
            document.getElementById('operating-profit-title').innerText += `: ${(fundamentals.find((item) => item.item === '영업이익').value || 0).toLocaleString()} 억원`;
            document.getElementById('net-profit-title').innerText += `: ${(fundamentals.find((item) => item.item === '당기순이익').value || 0).toLocaleString()} 억원`;
            document.getElementById('assets-title').innerText += `: ${(fundamentals.find((item) => item.item === '자산').value || 0).toLocaleString()} 억원`;

            const fundamentalList = data.fundamentalList; // success function 내에서 data를 받은 후, fundamentalList를 이렇게 할당해야 합니다.
            const ctx1 = document.getElementById('myChart1');
            const ctx2 = document.getElementById('myChart2');
            const ctx3 = document.getElementById('myChart3');
            const ctx4 = document.getElementById('myChart4');

            // 매출액
            const salesData = fundamentalList
                .filter(item => item.item === '매출액')
                .map(item => ({
                    year: item.regDate.split('-')[0], // 연도 정보만 추출합니다.
                    value: item.value,
                }));

            // 만약 마지막 연도가 2023이라면 '(E)'를 추가합니다.
            if (salesData.length > 0 && salesData[salesData.length - 1].year === '2023') {
                salesData[salesData.length - 1].year += ' (E)';
            }

            myChart1 = new Chart(ctx1, {
                type: 'bar',
                data: {
                    labels: salesData.map(item => item.year), // 연도 정보만을 라벨로 사용합니다.
                    datasets: [{
                        data: salesData.map(item => item.value), // 매출액 정보만을 데이터로 사용합니다.
                        backgroundColor: ['#cfd5df', '#cfd5df', '#1a4e98', '#c1e9ff'], // 요청한 색깔로 설정합니다.
                        borderWidth: 1
                    }]
                },
                options: {
                    plugins: {
                        legend: {
                            display: false // 범례를 표시하지 않습니다.
                        }
                    },
                    scales: {
                        y: {
                            display: false, // y축을 표시하지 않습니다.
                            beginAtZero: true
                        },
                        x: {
                            grid: {
                                display: false // x축의 그리드 라인을 표시하지 않습니다.
                            }
                        }
                    }
                }
            });

            // 영업이익
            const operatingProfitData = fundamentalList
                .filter(item => item.item === '영업이익')
                .map(item => ({
                    year: item.regDate.split('-')[0], // 연도 정보만 추출합니다.
                    value: item.value,
                }));

            // 만약 마지막 연도가 2023이라면 '(E)'를 추가합니다.
            if (operatingProfitData.length > 0 && operatingProfitData[operatingProfitData.length - 1].year === '2023') {
                operatingProfitData[operatingProfitData.length - 1].year += ' (E)';
            }

            myChart2 = new Chart(ctx2, {
                type: 'bar',
                data: {
                    labels: operatingProfitData.map(item => item.year), // 연도 정보만을 라벨로 사용합니다.
                    datasets: [{
                        data: operatingProfitData.map(item => item.value), // 매출액 정보만을 데이터로 사용합니다.
                        backgroundColor: ['#cfd5df', '#cfd5df', '#1a4e98', '#c1e9ff'], // 요청한 색깔로 설정합니다.
                        borderWidth: 1
                    }]
                },
                options: {
                    plugins: {
                        legend: {
                            display: false // 범례를 표시하지 않습니다.
                        }
                    },
                    scales: {
                        y: {
                            display: false, // y축을 표시하지 않습니다.
                            beginAtZero: true
                        },
                        x: {
                            grid: {
                                display: false // x축의 그리드 라인을 표시하지 않습니다.
                            }
                        }
                    }
                }
            });

            // 당기순이익
            const netProfitData = fundamentalList
                .filter(item => item.item === '당기순이익')
                .map(item => ({
                    year: item.regDate.split('-')[0], // 연도 정보만 추출합니다.
                    value: item.value,
                }));

            // 만약 마지막 연도가 2023이라면 '(E)'를 추가합니다.
            if (netProfitData.length > 0 && netProfitData[netProfitData.length - 1].year === '2023') {
                netProfitData[netProfitData.length - 1].year += ' (E)';
            }

            myChart3 = new Chart(ctx3, {
                type: 'bar',
                data: {
                    labels: netProfitData.map(item => item.year), // 연도 정보만을 라벨로 사용합니다.
                    datasets: [{
                        data: netProfitData.map(item => item.value), // 매출액 정보만을 데이터로 사용합니다.
                        backgroundColor: ['#cfd5df', '#cfd5df', '#1a4e98', '#c1e9ff'], // 요청한 색깔로 설정합니다.
                        borderWidth: 1
                    }]
                },
                options: {
                    plugins: {
                        legend: {
                            display: false // 범례를 표시하지 않습니다.
                        }
                    },
                    scales: {
                        y: {
                            display: false, // y축을 표시하지 않습니다.
                            beginAtZero: true
                        },
                        x: {
                            grid: {
                                display: false // x축의 그리드 라인을 표시하지 않습니다.
                            }
                        }
                    }
                }
            });

            // 자산
            const assetData = fundamentalList
                .filter(item => item.item === '자산')
                .map(item => ({
                    year: item.regDate.split('-')[0], // 연도 정보만 추출합니다.
                    value: item.value,
                }));

            // 만약 마지막 연도가 2023이라면 '(E)'를 추가합니다.
            if (assetData.length > 0 && assetData[assetData.length - 1].year === '2023') {
                assetData[assetData.length - 1].year += ' (E)';
            }

            myChart4 = new Chart(ctx4, {
                type: 'bar',
                data: {
                    labels: assetData.map(item => item.year), // 연도 정보만을 라벨로 사용합니다.
                    datasets: [{
                        data: assetData.map(item => item.value), // 매출액 정보만을 데이터로 사용합니다.
                        backgroundColor: ['#cfd5df', '#cfd5df', '#1a4e98', '#c1e9ff'], // 요청한 색깔로 설정합니다.
                        borderWidth: 1
                    }]
                },
                options: {
                    plugins: {
                        legend: {
                            display: false // 범례를 표시하지 않습니다.
                        }
                    },
                    scales: {
                        y: {
                            display: false, // y축을 표시하지 않습니다.
                            beginAtZero: true
                        },
                        x: {
                            grid: {
                                display: false // x축의 그리드 라인을 표시하지 않습니다.
                            }
                        }
                    }
                }
            });

            // 시장 정보 탭
            let valuationList = data.valuationList[0];

            $('td:contains("EPS") .content').text((valuationList.eps || 0).toLocaleString());
            $('td:contains("PER") .content').text((valuationList.per || 0).toLocaleString());
            $('td:contains("PBR") .content').text((valuationList.pbr || 0).toLocaleString());
            $('td:contains("DPS") .content').text((valuationList.dps || 0).toLocaleString());

            let marketCap = (latestOhlcv.close * issuedShares / 100000000) || 0;
            let marketCapStr = "";

            if (marketCap >= 10000) {
                marketCapStr = (marketCap / 10000).toFixed(2).toLocaleString() + ' 조 원';
            } else {
                marketCapStr = marketCap.toFixed(2).toLocaleString() + ' 억 원';
            }

            $('td:contains("시가총액") .content').text(marketCapStr);
            // $('td:contains("주가") .content').text((latestOhlcv.close || 0).toLocaleString() + ' 원');
            $('td').filter(function () {
                return $(this).find('.title').text().trim() === '주가';
            }).find('.content').text((latestOhlcv.close || 0).toLocaleString() + ' 원');

            $('td:contains("거래량") .content').text((latestOhlcv.volume || 0).toLocaleString() + ' 주');

            // 주가 변동율 계산 후 삽입
            function calculateChangeRate(currentPrice, previousPrice) {
                return ((currentPrice - previousPrice) / previousPrice) * 100;
            }

            function appendChangeRateElement(changeRate, label, container) {
                const roundedRate = changeRate.toFixed(2);
                const element = $('<div>').css('display', 'inline-block').css('margin-right', '10px');
                element.append($(`<span class="badge bg-light text-dark">${label}</span>`));

                if (changeRate > 0) {
                    element.append($('<span>').text(`+${roundedRate}%`).css('color', 'red'));
                } else if (changeRate < 0) {
                    element.append($('<span>').text(`${roundedRate}%`).css('color', 'blue'));
                } else {
                    element.append($('<span>').text(`${roundedRate}%`).css('color', 'black'));
                }
                container.append(element);
            }

            const changeRateContent = $('#change-rate-content');

            // 일별 변동율
            let dailyChangeRate = calculateChangeRate(latestOhlcv.close, data.ohlcvList[data.ohlcvList.length - 2].close);
            appendChangeRateElement(dailyChangeRate, '일', changeRateContent);
            // 주간 변동율
            let weeklyChangeRate = calculateChangeRate(latestOhlcv.close, data.ohlcvList[data.ohlcvList.length - (1 + 5)].close); // 가정: 하루에 한 번 기록
            appendChangeRateElement(weeklyChangeRate, '주', changeRateContent);
            // 월별 변동율
            let monthlyChangeRate = calculateChangeRate(latestOhlcv.close, data.ohlcvList[data.ohlcvList.length - (1 + 20)].close); // 가정: 하루에 한 번 기록
            appendChangeRateElement(monthlyChangeRate, '월', changeRateContent);

            // 다섯 번째 차트를 그립니다.
            let ohlcvList = data.ohlcvList; // ohlcvList를 사용해주세요.
            // let labels = ohlcvList.map(item => item.regDate);
            let labels = ohlcvList.map(item => {
                let date = new Date(item.regDate); // 문자열을 Date 객체로 변환합니다.
                let year = date.getFullYear(); // 년도를 얻습니다.
                let month = date.getMonth() + 1; // 월을 얻습니다. getMonth()는 0부터 시작하므로 1을 더합니다.
                return `${year}년 ${month}월`; // 변환된 라벨을 반환합니다.
            });
            let volumes = ohlcvList.map(item => item.volume);
            let closes = ohlcvList.map(item => item.close);
            let ctx5 = document.getElementById('myChart5').getContext('2d');

            let config5 = {
                type: 'bar',
                data: {
                    labels: labels,
                    datasets: [{
                        label: '거래량',
                        data: volumes,
                        backgroundColor: 'rgba(250, 140, 22)', // 주황색
                        borderColor: 'rgba(250, 140, 22)',
                        yAxisID: 'y-axis-volume',
                        order: 2
                    }, {
                        type: 'line',
                        label: '주가',
                        data: closes,
                        backgroundColor: 'rgba(68, 171, 255)', // 파란색
                        borderColor: 'rgba(68, 171, 255)',
                        yAxisID: 'y-axis-close',
                        order: 1,
                        pointRadius: 0,// 동그라미(포인트)를 그리지 않습니다.
                        pointRadius: closes.map((val, idx, arr) =>
                            idx === arr.indexOf(Math.max(...arr)) || idx === arr.indexOf(Math.min(...arr)) ? 5 : 0 // 최대, 최소값에서만 포인트 반지름 설정
                        ),
                        pointBackgroundColor: closes.map((val, idx, arr) =>
                            idx === arr.indexOf(Math.max(...arr)) ? '#f5322d' :
                                idx === arr.indexOf(Math.min(...arr)) ? '#b83dba' :
                                    'rgba(0,0,0,0)'
                        ),
                        pointBorderColor: closes.map((val, idx, arr) =>
                            idx === arr.indexOf(Math.max(...arr)) ? '#f5322d' :
                                idx === arr.indexOf(Math.min(...arr)) ? '#b83dba' :
                                    'rgba(0,0,0,0)'
                        )
                    }, {
                        type: 'scatter',
                        label: '최고가',
                        data: [{ x: null, y: null}],
                        yAxisID: 'y-axis-close',
                        pointRadius: 5,
                        pointBackgroundColor: '#f5322d',
                        pointBorderColor: '#f5322d',
                        showLine: false
                    },
                    {
                        type: 'scatter',
                        label: '최저가',
                        data: [{ x: null, y: null}],
                        yAxisID: 'y-axis-close',
                        pointRadius: 5,
                        pointBackgroundColor: '#b83dba',
                        pointBorderColor: '#b83dba',
                        showLine: false
                    }]
                },
                options: {
                    plugins: {
                        legend: {
                            position: 'bottom', // 범례를 차트의 하단에 위치시킵니다.
                            align: 'start', // 범례를 왼쪽 정렬합니다.
                        }
                        ,customLegendPadding: {
                            left: 10,
                            right: 0,
                            top: 20,
                            bottom: 0
                        }
                    },
                    scales: {
                        x: {
                            type: 'category',
                            ticks: {
                                autoSkip: true,
                                maxTicksLimit: 10
                            }
                        },
                        'y-axis-volume': {
                            type: 'linear',
                            position: 'left'
                        },
                        'y-axis-close': {
                            type: 'linear',
                            position: 'right'
                        }
                    }
                }
                ,plugins: [{
                    id: 'customLegendPadding',
                    beforeInit: (chart, args, options) => {
                        let padding = chart.options.plugins.customLegendPadding;
                        let legend = chart.options.plugins.legend;
                        legend.labels.padding += Math.max(padding.top, padding.bottom);
                    }
                }]
            };

            if (myChart5 && typeof myChart5.destroy === 'function') {
                myChart5.destroy();
            }
            myChart5 = new Chart(ctx5, config5);

            $('.btn-outline-secondary').click(function () {
                let range = $(this).data('range');
                let filteredData = filterData(ohlcvList, range);
                let newLabels = filteredData.map(item => {
                    let date = new Date(item.regDate); // 문자열을 Date 객체로 변환합니다.
                    let year = date.getFullYear(); // 년도를 얻습니다.
                    let month = date.getMonth() + 1; // 월을 얻습니다. getMonth()는 0부터 시작하므로 1을 더합니다.
                    return `${year}년 ${month}월`; // 변환된 라벨을 반환합니다.
                });
                let newVolumes = filteredData.map(item => item.volume);
                let newCloses = filteredData.map(item => item.close);

                let newConfig = {
                    type: 'bar',
                    data: {
                        labels: newLabels,
                        datasets: [{
                            label: '거래량',
                            data: newVolumes,
                            backgroundColor: 'rgba(250, 140, 22)', // 주황색
                            borderColor: 'rgba(250, 140, 22)',
                            yAxisID: 'y-axis-volume',
                            order: 2
                        }, {
                            type: 'line',
                            label: '주가',
                            data: newCloses,
                            backgroundColor: 'rgba(68, 171, 255)', // 파란색
                            borderColor: 'rgba(68, 171, 255)',
                            yAxisID: 'y-axis-close',
                            order: 1,
                            pointRadius: newCloses.map((val, idx, arr) =>
                                idx === arr.indexOf(Math.max(...arr)) || idx === arr.indexOf(Math.min(...arr)) ? 5 : 0
                            ),
                            pointBackgroundColor: newCloses.map((val, idx, arr) =>
                                idx === arr.indexOf(Math.max(...arr)) ? '#f5322d' :
                                    idx === arr.indexOf(Math.min(...arr)) ? '#b83dba' :
                                        'rgba(0,0,0,0)'
                            ),
                            pointBorderColor: newCloses.map((val, idx, arr) =>
                                idx === arr.indexOf(Math.max(...arr)) ? '#f5322d' :
                                    idx === arr.indexOf(Math.min(...arr)) ? '#b83dba' :
                                        'rgba(0,0,0,0)'
                            )
                        }, {
                            type: 'scatter',
                            label: '최고가',
                            data: [{ x: null, y: null}],
                            yAxisID: 'y-axis-close',
                            pointRadius: 5,
                            pointBackgroundColor: '#f5322d',
                            pointBorderColor: '#f5322d',
                            showLine: false
                        },
                        {
                            type: 'scatter',
                            label: '최저가',
                            data: [{ x: null, y: null}],
                            yAxisID: 'y-axis-close',
                            pointRadius: 5,
                            pointBackgroundColor: '#b83dba',
                            pointBorderColor: '#b83dba',
                            showLine: false
                        }]
                    },
                    options: config5.options
                };

                if (myChart5 && typeof myChart5.destroy === 'function') {
                    myChart5.destroy();
                }
                myChart5 = new Chart(ctx5, newConfig);
            });

            // 경쟁사탭
            let stockChartList = data.stockChartList;
            // $('#stockChartList').html(generateStockChartHtml(stockChartList));

            globalStockChartList = stockChartList; // 데이터 저장
            var stockChartHtml = generateStockChartHtml(globalStockChartList, currentlySelectedIsins);
            $('#stockChartList').html(stockChartHtml);

            if(data.tags) {
                populateTags(data.tags);
            }
        },
        error: function () {
            alert("차트 그리기 실패");
        },
    });
}

function filterData(data, range) {
    const now = new Date();
    let filteredData;
    switch (range) {
        case '1m': // 최근 1달 데이터
            filteredData = data.filter(item => {
                const date = new Date(item.regDate);
                return now - date <= 30 * 24 * 60 * 60 * 1000; // 30일을 밀리초로 변환
            });
            break;
        case '3m': // 최근 3달 데이터
            filteredData = data.filter(item => {
                const date = new Date(item.regDate);
                return now - date <= 3 * 30 * 24 * 60 * 60 * 1000; // 3개월을 밀리초로 변환
            });
            break;
        case '1y': // 올해 데이터
            filteredData = data.filter(item => {
                const date = new Date(item.regDate);
                return date.getFullYear() === now.getFullYear();
            });
            break;
        case '12m': // 최근 1년 데이터
            filteredData = data.filter(item => {
                const date = new Date(item.regDate);
                return now - date <= 12 * 30 * 24 * 60 * 60 * 1000; // 12개월을 밀리초로 변환
            });
            break;
        case '60m': // 최근 5년 데이터
            filteredData = data.filter(item => {
                const date = new Date(item.regDate);
                return now - date <= 5 * 12 * 30 * 24 * 60 * 60 * 1000; // 5년을 밀리초로 변환
            });
            break;
        case 'all': // 전체 데이터
            filteredData = data;
            break;
        default:
            filteredData = data;
            break;
    }
    return filteredData;
}

// 경쟁사 탭
var selectedStocks = [];
var currentlySelectedIsins = [];

$('body').on('click', '.clickable', function() {
    var stock = $(this).data('stock');
    var stockName = $(this).find('h5').text().trim();
    var isinValue = $(this).find('p').first().text().trim().split(' ')[0];

    if($(this).hasClass('selected')) {
        $(this).removeClass('selected');
        selectedStocks = selectedStocks.filter(function(item) {
            return item !== stock;
        });

        // 선택 해제된 카드의 기업명에 해당하는 버튼을 제거합니다.
        $(".col.d-flex").find("button:contains('" + stockName + "')").remove();

    } else {
        $(this).addClass('selected');
        selectedStocks.push(stock);

        // 새로운 기업명 버튼을 추가합니다. 여기서 data-isin 속성을 추가하여 버튼에 ISIN 값을 저장합니다.
        var newButton = `<button type="button" class="custom-button" data-isin="${isinValue}">${stockName} X</button>`;
        $(".col.d-flex").append(newButton);
    }

    sendSelectedStocks();
});

$('body').on('click', '.custom-button', function() {
    var companyName = $(this).text().replace(" X", "").trim();

    // 카드에서 해당 기업명을 가진 요소의 선택 상태를 제거합니다.
    $('.clickable:contains(' + companyName + ')').removeClass('selected');

    // 선택 해제된 카드의 기업명에 해당하는 버튼을 제거합니다.
    $(".col.d-flex").find("button:contains('" + companyName + "')").remove();

    // 기업명 버튼을 제거한 후에도 AJAX 요청을 보냅니다.
    sendSelectedStocks();
});

let stockChart = [];
let selectedRadioId;

function sendSelectedStocks() {
    // 선택된 카드의 isin 값을 저장할 배열
    var selectedIsinValues = getSelectedIsins();

    // 서버에 AJAX 요청을 보내기
    $.ajax({
        url: '/get-taged-stock',
        method: 'POST',
        data: JSON.stringify(selectedIsinValues),
        contentType: 'application/json',
        success: function(response) {
            console.log('Data received successfully!', response);
            drawSelectedStockChart(response);

            // 주식 종목별로 데이터를 그룹화
            const groupedData = groupBy(response, 'isin');

            $('#stockDataTable tbody').html(''); // 테이블 초기화
            const stockDataArray = []; // 각 주식 종목의 데이터를 저장하는 배열

            for (const isin in groupedData) {
                const stockDatas = groupedData[isin];

                // 최근 3년 데이터
                const latestData = stockDatas[stockDatas.length - 1];
                const secondLatestData = stockDatas[stockDatas.length - 2];
                const thirdLatestData = stockDatas[stockDatas.length - 3];

                // 성장성: 최근 3년 매출액 연평균 증가율
                const salesGrowth = (
                    ((latestData.sales / thirdLatestData.sales) - 1) +
                    ((secondLatestData.sales / thirdLatestData.sales) - 1) +
                    ((latestData.sales / secondLatestData.sales) - 1)
                ) / 3 * 100;

                // 수익성: 직전연도 영업이익률
                const profitability = (secondLatestData.operatingProfit / secondLatestData.sales) * 100;

                // 안정성: 직전연도 부채비율
                const stability = (secondLatestData.liabilities / secondLatestData.assets) * 100;

                // 배당: 배당수익률 계산
                const dividendYield = (latestData.dividendPayment * 100000000 / latestData.issuedShares / latestData.close) * 100;

                // 벨류에이션: PER
                const valuation = latestData.per;

                // 데이터 배열에 각 지표 값을 넣음
                stockDataArray.push({
                    stockName: latestData.stockName,
                    salesGrowth,
                    profitability,
                    stability,
                    dividendYield,
                    valuation
                });

                // 테이블 업데이트
                updateTable(latestData.stockName, salesGrowth, profitability, stability, dividendYield, valuation);
            }

            // 점수 부여 함수
            function assignScores(dataArray, key, ascending = true) {
                dataArray.sort((a, b) => ascending ? a[key] - b[key] : b[key] - a[key]);
                const len = dataArray.length;
                const interval = 8 / (len - 1);
                for (let i = 0; i < len; i++) {
                    dataArray[i][key] = 2 + i * interval;
                }
            }

            // 각 지표에 대한 점수 부여
            assignScores(stockDataArray, 'salesGrowth');
            assignScores(stockDataArray, 'profitability');
            assignScores(stockDataArray, 'stability', false);
            assignScores(stockDataArray, 'dividendYield');
            assignScores(stockDataArray, 'valuation');

            // 준비된 데이터로 차트 그리기
            drawChart7(stockDataArray);
        },
        error: function(error) {
            console.error('Error sending data:', error);
        }
    });
};

function populateTags(tags) {
    var tagListElement = $(".list-group");

    // 첫 번째 태그를 제외한 나머지 태그를 모두 제거합니다.
    tagListElement.find(".list-group-item:not(:first-child)").remove();

    $.each(tags, function(index, tag) {
        var tagName = tag.tagName;
        var tagId = tag.tagId;  // tag 맵에서 tagId 값을 가져옵니다.
        var listItem = $('<li class="list-group-item">')
            .text('태그 : ' + tagName)
            .attr('data-tag-id', tagId);  // data-tag-id 속성에 tagId 값을 저장합니다.
        tagListElement.append(listItem);
    });
};

// 외부에 선택된 ISIN 목록을 저장하는 배열
var currentlySelectedIsins = [];

$(document).on('click', '.list-group-item', function() {
    var tagId = $(this).attr('data-tag-id');
    var sector = $(this).attr('data-sector');

    if (sector) {  // sector 값이 있으면 산업 태그를 선택한 것입니다.
        var selectedIsins = getSelectedIsins();
        var stockChartHtml = generateStockChartHtml(globalStockChartList, selectedIsins);
        $('#stockChartList').html(stockChartHtml);
    } else {
        $.ajax({
            url: "/get-tagId",
            type: "POST",
            data: {
                tagId: tagId
            },
            success: function(response) {
                if (response && response.selectStocksByTag) {
                    var selectedIsins = getSelectedIsins();
                    var stockChartHtml = generateStockChartHtml(response.selectStocksByTag, selectedIsins);
                    $('#stockChartList').html(stockChartHtml);
                }
            },
            error: function(error) {
                console.error("Error sending tagId:", error);
            }
        });
    }
});

function getSelectedIsins() {
    var selectedIsinValues = [];
    selectedIsinValues.push(currentIsin);

    // custom-button 클래스를 가진 요소들을 순회하며 isin 값을 배열에 추가
    $('.custom-button').each(function() {
        var isinValue = $(this).data('isin');
        if (!selectedIsinValues.includes(isinValue)) {
            selectedIsinValues.push(isinValue);
        }
    });
    return selectedIsinValues;
}

function generateStockChartHtml(stockChartList, selectedIsins) {
    selectedIsins = selectedIsins || []; // selectedIsins가 undefined 또는 null인 경우, 빈 배열로 초기화

    let stockChartListHtml = '';
    for (let i = 0; i < stockChartList.length; i++) {
        // currentIsin과 동일한 경우 continue를 사용해 현재 반복을 건너뛰기
        if (stockChartList[i].isin === currentIsin) {
            continue;
        }

        let isSelected = selectedIsins.includes(stockChartList[i].isin) ? 'selected' : '';
        stockChartListHtml += `
            <div class="col-md-4">
                <div class="card border-primary border">
                    <div class="card-body clickable ${isSelected}" data-stock="stock${i}">
                        <div class="d-flex align-items-start">
                            <img src="../../../resources/img/logo/${stockChartList[i].isin}.png" alt="image" class="me-3 d-none d-sm-block avatar-sm rounded-circle">
                            <div class="w-100 overflow-hidden">
                                <h5 class="mb-1 mt-0">${stockChartList[i].stockName}</h5>
                                <p>${stockChartList[i].isin} 코스피 </p>
                                <p class="mb-0 text-muted" style="font-size: 0.8rem;">
                                    <b>매출액 : ${stockChartList[i].sales}</b><br/>
                                    자산 : ${stockChartList[i].assets}<br/>
                                    부채 : ${stockChartList[i].liabilities}<br/>
                                </p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>`;
    }
    return stockChartListHtml;
}

function drawSelectedStockChart(response) {
    // 2022년 데이터만 필터링
    const filteredData = response.filter(stock => stock.regDate.startsWith("2022"));

    // 첫 라디오 버튼의 데이터를 기본값으로 차트 생성
    if (myChart6) {
        myChart6.destroy(); // 기존 차트 파괴
    }
    drawChart(filteredData);

    // 라디오 버튼 클릭 이벤트 연결
    $('input[name="customRadio1"]').off('change').on('change', function() {
        if (myChart6) {
            myChart6.destroy(); // 기존 차트 파괴
        }
        drawChart(filteredData); // response는 AJAX로 받아온 데이터
    });
}

// myChart6 그리기
var ctx6 = document.getElementById('myChart6').getContext('2d');

function drawChart(stockDataList) {
    const selectedValue = $('input[name="customRadio1"]:checked').attr('id');

    let dataField = '';
    switch (selectedValue) {
        case 'customRadio1': dataField = 'sales'; break;
        case 'customRadio2': dataField = 'assets'; break;
        case 'customRadio3': dataField = 'liabilities'; break;
        case 'customRadio4': dataField = 'retainedEarnings'; break;
        case 'customRadio5': dataField = 'dividendPayment'; break;
    }

    // 현재 선택된 isin의 항목을 찾습니다.
    const currentIsinItem = stockDataList.find(stock => stock.isin === currentIsin);
    const otherItems = stockDataList.filter(stock => stock.isin !== currentIsin);

    // 나머지 항목들을 선택된 dataField의 값에 따라 내림차순으로 정렬합니다.
    otherItems.sort((a, b) => b[dataField] - a[dataField]);

    // 정렬된 목록 앞에 currentIsin의 항목을 추가합니다.
    const sortedList = [currentIsinItem, ...otherItems];

    const newLabels = sortedList.map(stock => stock.stockName);
    const newData = sortedList.map(stock => stock[dataField]);

    // backgroundColor와 borderColor를 동적으로 생성
    const backgroundColors = ['rgba(251, 202, 0)']; // 맨 앞은 노란색
    const borderColors = ['rgba(251, 202, 0)']; // 맨 앞의 노란색 border

    // 나머지 항목들을 파란색으로 설정
    for (let i = 1; i < sortedList.length; i++) {
        backgroundColors.push('rgba(10, 95, 255)');
        borderColors.push('rgba(10, 95, 255)');
    }

    var ctx6 = document.getElementById('myChart6').getContext('2d');
    myChart6 = new Chart(ctx6, {
        type: 'bar',
        data: {
            labels: newLabels,
            datasets: [{
                label: 'Dataset',
                data: newData,
                backgroundColor: backgroundColors,
                borderColor: borderColors,
                borderWidth: 1
            }]
        },
        options: {
            maintainAspectRatio: false,
            scales: {
                y: {
                    beginAtZero: true,
                    ticks: {
                        display: false, // y축 눈금을 삭제하기 위한 옵션
                    },
                    grid: {
                        drawBorder: false, // y축 경계선을 삭제하기 위한 옵션
                    },
                }
            },
            plugins: {
                legend: {
                    display: false, // 범례를 삭제하기 위한 옵션
                }
            }
        },
    });
}

// 객체 배열을 키에 따라 그룹화하는 함수
function groupBy(list, key) {
    return list.reduce((acc, item) => {
        (acc[item[key]] = acc[item[key]] || []).push(item);
        return acc;
    }, {});
}

function updateTable(stockName, salesGrowth, profitability, stability, dividendYield, valuation) {
    const newRow = `
        <tr>
            <td>${stockName}</td>
            <td>${salesGrowth.toFixed(2)}%</td>
            <td>${profitability.toFixed(2)}%</td>
            <td>${stability.toFixed(2)}%</td>
            <td>${dividendYield.toFixed(2)}%</td>
            <td>${valuation.toFixed(2)}</td>
        </tr>
    `;
    $('#stockDataTable tbody').append(newRow); // 테이블에 새로운 행 추가
}

function drawChart7(stockDataList) {
    var ctx7 = document.getElementById('myChart7').getContext('2d');

    if (myChart7) {
        myChart7.destroy(); // 기존 차트 파괴
    }

    const datasets = stockDataList.map((stockData, index) => {
        const color = predefinedColors[index % predefinedColors.length]; // 목록을 반복하여 사용합니다.

        return {
            label: stockData.stockName,
            data: [stockData.salesGrowth, stockData.profitability, stockData.stability, stockData.dividendYield, stockData.valuation],
            fill: true,
            backgroundColor: color.bg,
            borderColor: color.border,
            pointBackgroundColor: color.border,
            pointBorderColor: '#fff',
            pointHoverBackgroundColor: '#fff',
            pointHoverBorderColor: color.border
        };
    });

    const data7 = {
        labels: ['성장성', '수익성', '안정성', '배당', '벨류에이션'],
        datasets: datasets
    };

    myChart7 = new Chart(ctx7, {
        type: 'radar',
        data: data7,
        options: {
            elements: {
                line: {
                    borderWidth: 3
                }
            },
            scales: {
                r: {
                    ticks: {
                        display: false
                    }
                }
            },
            plugins: {
                legend: {
                    position: 'right'
                }
            }
        },
    });
}

const predefinedColors = [
    { bg: 'rgba(255, 99, 132, 0.2)', border: 'rgb(255, 99, 132)' },
    { bg: 'rgba(75, 192, 192, 0.2)', border: 'rgb(75, 192, 192)' },
    { bg: 'rgba(255, 205, 86, 0.2)', border: 'rgb(255, 205, 86)' },
    { bg: 'rgba(201, 203, 207, 0.2)', border: 'rgb(201, 203, 207)' },
    { bg: 'rgba(54, 162, 235, 0.2)', border: 'rgb(54, 162, 235)' },
    { bg: 'rgba(153, 102, 255, 0.2)', border: 'rgb(153, 102, 255)' },
    { bg: 'rgba(255, 159, 64, 0.2)', border: 'rgb(255, 159, 64)' },
    { bg: 'rgba(131, 58, 180, 0.2)', border: 'rgb(131, 58, 180)' },
    { bg: 'rgba(46, 204, 113, 0.2)', border: 'rgb(46, 204, 113)' },
    { bg: 'rgba(231, 76, 60, 0.2)', border: 'rgb(231, 76, 60)' }
];