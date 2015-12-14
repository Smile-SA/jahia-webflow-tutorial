<%@ taglib prefix="jcr" uri="http://www.jahia.org/tags/jcr" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="utility" uri="http://www.jahia.org/tags/utilityLib" %>
<%@ taglib prefix="template" uri="http://www.jahia.org/tags/templateLib" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<div class="well span6" style="float:none;margin:0 auto">
    <h2>
        <fmt:message key="wfnt_form.title">
            <fmt:param value="${currentNode.user.name}"/>
        </fmt:message>
    </h2>
    <dl class="dl-horizontal">
        <dt>
            <fmt:message key="wfnt_form.email"/>
        </dt>
        <dd>
            <c:out value="${contactInfo.email}"/>
        </dd>
        <dt>
            <fmt:message key="wfnt_form.phone"/>
        </dt>
        <dd>
            <c:out value="${contactInfo.phone}"/>
        </dd>
        <dt>
            <fmt:message key="wfnt_form.mobile"/>
        </dt>
        <dd>
            <c:out value="${contactInfo.mobile}"/>
        </dd>
    </dl>

    <div class="pull-right">
        <form:form modelAttribute="contactInfo" class="form-horizontal" method="post">
            <button id="next" class="btn btn-primary" type="submit" name="_eventId_next">
                <fmt:message key="wfnt_form.label.update"/>
            </button>
        </form:form>
    </div>
</div>