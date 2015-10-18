<%@ taglib prefix="jcr" uri="http://www.jahia.org/tags/jcr" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="utility" uri="http://www.jahia.org/tags/utilityLib" %>
<%@ taglib prefix="template" uri="http://www.jahia.org/tags/templateLib" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<c:set var="values" value="${currentUser.properties}"/>

<div class="well span6" style="float:none;margin:0 auto">
    <h2>Informations de contact</h2>
    <dl class="dl-horizontal">
        <dt>
            <fmt:message key="wfnt_form.email"/>
        </dt>
        <dd>
            <c:if test="${not empty currentUser.properties['j:email'] }">
                ${fn:escapeXml(currentUser.properties['j:email'])}
            </c:if>
        </dd>
        <dt>
            <fmt:message key="wfnt_form.phone"/>
        </dt>
        <dd>
        </dd>
        <dt>
            <fmt:message key="wfnt_form.mobile"/>
        </dt>
        <dd>
        </dd>
    </dl>
    <div class="pull-right">

        <c:url value='${url.base}${currentNode.path}.webflow-update.html' var="updateUrl"/>
        <a class="btn btn-default" href="${updateUrl}"
           title="Modifier ces informations en commen&ccaron;ant un formulaire sur plusieurs &eacute;tapes">
            <fmt:message key="wfnt_form.label.update"/>
        </a>
    </div>
</div>