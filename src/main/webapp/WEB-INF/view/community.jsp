<%@ page contentType="text/html;charset=UTF-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <meta charset="UTF-8">
    <title>${communityInvitations.name}社区</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/static/bootstrap/css/bootstrap.min.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/static/css/style.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/static/css/header.css">
</head>
<body>
<%@include file="header.jsp"%>
<main class="container mt-3">
    <div class="bg-light pl-3 pr-3 pt-3 mt-2">
        <div class="border bg-transparent p-3">
            <h5>${communityInvitations.name}社区</h5>
            <p>
                <c:choose>
                    <c:when test="${empty communityInvitations.introduction}">暂无简介</c:when>
                    <c:otherwise>${communityInvitations.introduction}</c:otherwise>
                </c:choose>
            </p>
        </div>
        <ul class="mt-3">
            <c:forEach items="${communityInvitations.invitationUsers}" var="invitationUser">
                <li class="d-flex flex-column border-bottom">
                    <div class="row">
                        <a class="text-primary" href="/invitation/${invitationUser.id}">${invitationUser.title}</a>
                        <span class="flex-grow-1 d-flex justify-content-end pr-3 time">${invitationUser.username}</span>
                    </div>
                    <div class="row">
                        <span class="content">${invitationUser.content}</span>
                        <span class="flex-grow-1 d-flex justify-content-end pr-3 time">${invitationUser.time}</span>
                    </div>
                </li>
            </c:forEach>
        </ul>
        <h5>发表新帖</h5>
        <form method="post" action="${pageContext.request.contextPath}/publishInvitation">
            <input type="text" maxlength="50" placeholder="请输入标题" class="w-100 pl-3 mt-3 mb-3 title" id="title" />
            <div id="contentEidtor"></div>
            <textarea style="display: none" id="content"></textarea>
            <button type="button" class="mt-3 btn btn-danger" id="publishButton" onclick="publishInvitation()">发表</button>
        </form>
    </div>
</main>
<script src="${pageContext.request.contextPath}/static/js/jquery.min.js"></script>
<script src="${pageContext.request.contextPath}/static/bootstrap/js/bootstrap.min.js"></script>
<script src="${pageContext.request.contextPath}/static/wangEditor/wangEditor.min.js"></script>
<script>
    // 创建富文本编辑器
    let E = window.wangEditor;
    let editor = new E('#contentEidtor');
    let $text1 = $('#content');
    editor.customConfig.onchange = function(html) {
        $text1.val(html)
    };
    editor.create();
    $text1.val(editor.txt.html());
    // 用户未登录，禁用发贴功能
    if (${empty sessionScope.userStatus}){
        editor.txt.html("你还没有登录");
        editor.$textElem.css("text-align","center");
        editor.$textElem.attr('contenteditable', false);
        $("#title").attr("disabled",true);
        $("#publishButton").attr("disabled",true);
    }
    function publishInvitation() {
        let invitation = {
            communityId : ${communityInvitations.id},
            <c:if test="${sessionScope.userId!=null}">userId:${sessionScope.userId},</c:if>
            title:$("#title").val(),
            content:$("#content").val()
        };
        $.ajax({
            url:"/publishInvitation",
            type:"POST",
            data:invitation,
            dataType:"json",
            success:function (response) {
                if (response.success){
                    alert(response.message);
                    window.location.reload();
                } else {
                    alert(response.message);
                }
            }
        })
    }
</script>
</body>
</html>
