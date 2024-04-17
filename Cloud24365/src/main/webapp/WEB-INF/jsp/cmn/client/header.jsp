<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<div style="display: flex; align-items: center; height: 100%;">
	<h1 class='logo'>
			<a href="/">logo</a>
	</h1>
</div>
<div class="header_util">
	<div class="username">
		<ul class="nav-icons" style="margin-top: 0px;">
			<c:choose>
				<c:when test="${login.USER_NAME != null}">
					<li style="display: flex;">
						<i class="ion-person"></i>
						<div style="margin-left: 10px;">${login.USER_NAME}님 환영합니다.</div>
						<a href="/login/logout.do" style="margin-left: 10px;">logout</a>
						<a href="/client/support/request/reqInsert.do" style="margin-left: 10px;">문의하기</a>
					</li>
				</c:when>
				<c:otherwise>
					<li style="display: flex;">
						<a href="/login/login.do" style="margin-left: 10px;">login</a>
					</li>
				</c:otherwise>
			</c:choose>
		</ul>
	</div>
</div>