var ws;
var currentRoomId; // 전역 변수로 선언

function openChatRoom(roomId) {
    currentRoomId = roomId;
    $.ajax({
        url: '/chat/' + roomId,
        type: 'GET',
        dataType: 'json',
        success: function(response) {
            renderMessages(response.messages);
            renderParticipants(response.participants);
            wsOpen(roomId);
        },
        error: function(err) {
            console.error("Error fetching chat messages: ", err);
        }
    });
}

function formatTime(dateString) {
    var date = new Date(dateString);
    var hours = date.getHours();
    var minutes = date.getMinutes();

    // 시간 및 분을 2자리로 만들기 위해 앞에 0을 추가
    hours = hours < 10 ? '0' + hours : hours;
    minutes = minutes < 10 ? '0' + minutes : minutes;

    return hours + ':' + minutes;
}

function renderMessages(messages) {
    var messageContainer = $(".conversation-list");
    messageContainer.empty(); // 기존 메시지 삭제

    messages.forEach(function(message) {
        var isCurrentUser = (currentUserId === message.memberId);
        var messageClass = isCurrentUser ? "clearfix odd" : "clearfix";
        var displayName = isCurrentUser ? currentUserId : message.memberId; // 또는 필요한 다른 로직을 사용하여 이름을 가져올 수 있습니다.

        var formattedTime = formatTime(message.regDate);

        var messageElement = `
            <li class="${messageClass}">
                <div class="chat-avatar">
                    <img src="../../../resources/img/person/${displayName}.jpg" class="rounded" alt="${displayName}" />
                    <i>${formattedTime}</i>
                </div>
                <div class="conversation-text">
                    <div class="ctext-wrap">
                        <i>${displayName}</i>
                        <p>${message.content}</p>
                    </div>
                </div>
            </li>
        `;
        messageContainer.append(messageElement);
    });
    var existingInstance = SimpleBar.instances.get(messageContainer[0]);
    if (existingInstance) {
        existingInstance.unMount();
        existingInstance = null;
    }
    new SimpleBar(messageContainer[0]);

    // SimpleBar 인스턴스를 얻어옵니다.
    var simpleBarInstance = SimpleBar.instances.get(document.querySelector(".conversation-list"));
    // 스크롤을 가장 아래로 내립니다.
    if (simpleBarInstance) {
        var scrollElement = simpleBarInstance.getScrollElement();
        scrollElement.scrollTop = scrollElement.scrollHeight;
    }
}

// 채팅 참여자 그리기
function renderParticipants(participants) {
    var participantContainer = $(".participation-list");
    participantContainer.empty(); // 기존 참여자 삭제

    participants.forEach(function(participant) {
        var participantElement = `
            <div style="display: flex; flex-direction: column; align-items: center; margin-bottom: 10px;">
                <img src="../../../resources/img/person/${participant}.jpg" class="me-2 rounded-circle" height="48" alt="User Image" />
                <span class="text-muted font-14">${participant}</span>
            </div>
        `;
        participantContainer.append(participantElement);
    });
}

// 가장 상위 채팅방 그리기
$(document).ready(function() {
    var firstRoomId = $(".text-body").first().data("room-id");
    if(firstRoomId) {
        openChatRoom(firstRoomId);
    }
});

function wsOpen(roomId) {
    if (ws) {
        ws.close(); // 기존 연결을 종료합니다.
    }
    const socketUrl = "ws://" + location.host + "/chat/chat/" + roomId;
    ws = new WebSocket(socketUrl);
    wsEvt();
}

function wsEvt() {
    ws.onopen = function(data){
        //소켓이 열리면 초기화 세팅하기
    }

    ws.onmessage = function(data) {
        var msgContent = data.data;

        if (msgContent != null && msgContent.trim() !== '') {
            var parts = msgContent.split(" : ");
            var displayName = parts[0];
            var msgText = parts[1];
            var now = new Date(); // 현재 날짜 및 시간을 가져옵니다.
            var regDate = now.toISOString(); // 새 메시지의 날짜 및 시간을 설정합니다.

            var message = {
                memberId: displayName,
                content: msgText,
                regDate: regDate
            };

            // 현재 채팅 내용에 새 메시지 추가
            var currentMessages = $(".conversation-list li").map(function () {
                var dateStr = $(this).find(".chat-avatar i").text().split(':');
                var messageDate = new Date(now.getFullYear(), now.getMonth(), now.getDate(), parseInt(dateStr[0]), parseInt(dateStr[1]));

                return {
                    memberId: $(this).find(".ctext-wrap i").text(),
                    content: $(this).find(".ctext-wrap p").text(),
                    regDate: messageDate.toISOString()
                };
            }).get();

            currentMessages.push(message);

            renderMessages(currentMessages);

            // SimpleBar 인스턴스를 얻어옵니다.
            var simpleBarInstance = SimpleBar.instances.get(document.querySelector(".conversation-list"));

            // 스크롤을 가장 아래로 내립니다.
            if (simpleBarInstance) {
                var scrollElement = simpleBarInstance.getScrollElement();
                scrollElement.scrollTop = scrollElement.scrollHeight;
            }
        }
    }
    document.removeEventListener("keypress", sendOnEnter); // 기존 이벤트 리스너 제거
    document.addEventListener("keypress", sendOnEnter);
}

function sendOnEnter(e) {
    if(e.keyCode == 13){ //enter press
        e.preventDefault();  // 기본 동작(페이지 새로고침)을 막습니다.
        send(currentRoomId);
    }
}

function send() {
    var uN = currentUserId;
    var msg = $("#chat").val();

    if (ws && ws.readyState === WebSocket.OPEN) {
        // 메시지를 웹소켓을 통해 전송
        ws.send(uN + " : " + msg + " : " + currentRoomId);
        // 입력 필드 지우기
        $('#chat').val("");
    } else {
        console.error("WebSocket is not open!");
    }
};
