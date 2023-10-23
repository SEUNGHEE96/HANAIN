// 마이데이터 계좌 그리기
function generateAccountCardHtml(accountList) {
    let accountListHtml = '';
    for (let i = 0; i < accountList.length; i++) {
        if (renderedAccountNumbers.includes(accountList[i].accountNumber.toString())) {
            continue;
        }
        let balancesDiv = generateBalancesDiv(accountList[i].balances);

        accountListHtml += `
            <div class="col-md-6">
                <div class="card border-primary border" style="margin-bottom: 0px !important;">
                    <div class="card-body clickable" data-stock="account${i}">
                        <div class="d-flex align-items-start">
                            <img src="../../../resources/img/company/${accountList[i].company}.png" alt="image" class="me-3 d-none d-sm-block avatar-sm rounded-circle">
                            <div class="w-100 overflow-hidden">
                                <h5 class="mb-1 mt-0">${accountList[i].company}</h5>
                                <p>계좌번호 : ${accountList[i].accountNumber}</p>
                                <p class="mb-0 text-muted" style="font-size: 0.8rem;">
                                    <b>현금 : ${accountList[i].cash}</b><br/>
                                </p>
                                ${balancesDiv}
                            </div>
                        </div>
                    </div>
                </div>
            </div>`;
    }
    return accountListHtml;
};

function generateBalancesDiv(balances) {
    let balancesHtml = '<div class="balances" style="display: none;">';
    for (let balance of balances) {
        balancesHtml += `<div data-isin="${balance.isin}" data-quantity="${balance.quantity}" data-averagePrice="${balance.averagePrice}"></div>`;
    }
    balancesHtml += '</div>';
    return balancesHtml;
}