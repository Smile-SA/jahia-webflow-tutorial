<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="jcr" uri="http://www.jahia.org/tags/jcr" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<c:set var="page" value="${jcr:getParentOfType(currentNode, 'jnt:page')}"/>
<c:url value="${page.url}" var="backUrl"/>

<div class="well span6" style="float:none;margin:0 auto">
    <p class="text-success"><fmt:message key="wfnt_form.success.title"/></p>

    <div class="pull-right">
        <a class="btn btn-success" href="${backUrl}">Retour</a>
    </div>
</div>