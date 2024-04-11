<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!-- 
<table>
    <c:forEach var="mappedMenu" items="${mappedMenuList}" varStatus="idx">
        <tr>
            <td><input type="checkbox" id="check${idx.count}" name="check${idx.count}" value="${mappedMenu.MENU_ID}" <c:if test="${mappedMenu.CHECK_YN eq 'Y'}">checked</c:if>/></td>
            <td>${mappedMenu.MENU_NAME}</td>
        </tr>
    </c:forEach>
</table>
 -->

<!-- 
<div id="db_layer11">
    <div class="tit11 txt_right mgr_lb"></div>
    <div class="tit11_1 scroll">
        <ul>
        	<c:forEach var="mappedMenu" items="${mappedMenuList}" varStatus="idx">
            <li><input type="checkbox" id="check${idx.count}" name="check${idx.count}" value="${mappedMenu.MENU_ID}" <c:if test="${mappedMenu.CHECK_YN eq 'Y'}">checked</c:if>/>${mappedMenu.MENU_NAME}</li>
            </c:forEach>
        </ul>
    </div>
</div>
-->

<ul>
    <c:forEach var="mappedMenu" items="${mappedMenuList}" varStatus="idx">
    <li>
    	<input type="checkbox" id="check${idx.count}" name="check${idx.count}" value="${mappedMenu.MENU_ID}" <c:if test="${mappedMenu.CHECK_YN eq 'Y'}">checked</c:if>/>${mappedMenu.MENU_NAME}
    </li>
    </c:forEach>
</ul>