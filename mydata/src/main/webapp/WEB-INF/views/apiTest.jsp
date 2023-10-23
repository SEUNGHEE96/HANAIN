<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

</head>
<body>
	테스트
	<script src="http://code.jquery.com/jquery-latest.js"></script> 
    <script type="text/javascript">
    $(document).ready(function(){ //홈페이지에 들어가면
            $.ajax({
                url : '${pageContext.request.contextPath}/gethometaxinfo.json',
                method : 'post',
                data : {
                    id : 'lovehana',
                    password : 'lovehana',
                },
                success : function(){
                    alert('성공');
                    alert(data);
                },
                error : function(){
                    alert('실패')
                },
                
            })
        
    })
    </script>
</body>
</html>