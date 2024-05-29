<?xml version="1.0" encoding="UTF-8"?>
<%@ page contentType="text/xml; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" 	   uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<sitemapindex xmlns="http://www.sitemaps.org/schemas/sitemap/0.9">
	<c:forEach var="mMenu" items="${MENU_LIST}" varStatus="status">
		<c:forEach var="sMenu" items="${mMenu.SUB_MENU}" varStatus="statusS">
		<sitemap>
		    <loc>http://sangokch.org${fn:replace(sMenu.URL, '&', '&amp;')}</loc>
		    <lastmod>${NOW}</lastmod>
		</sitemap>
		</c:forEach>
	</c:forEach>
</sitemapindex>
