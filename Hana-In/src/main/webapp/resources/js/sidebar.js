$(document).ready(function () {
    //$('#search-box').on('input', function () {
    $(document).on('input', '#search-box', function() {
        const input = $('#search-box').val();
        $.ajax({
            url: '/stock-searching',  // API endpoint
            type: 'GET',
            data: {
                'input': input
            },
            success: function (data) {
                var resultHtml = '';
                for (var i = 0; i < data.length; i++) {
                    resultHtml += '<div class="search-result-item">' + data[i].isin + ' ' + data[i].stockName + '</div>';
                }
                $('.search-result').html(resultHtml).show();
            },
            error: function (data) {
                console.error("AJAX 요청 실패: ", data);
            },
        });
    });

    // Hide the search result when the user clicks outside
    $(document).click(function (event) {
        if (!$(event.target).closest('.searchBar').length) {
            $('.search-result').hide();
        }
    });

    // Select the search result and fill in the search box
    $(document).on('click', '.search-result div', function () {
        $('#search-box').val($(this).text());
    });

});