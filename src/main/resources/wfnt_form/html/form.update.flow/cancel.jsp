<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="jcr" uri="http://www.jahia.org/tags/jcr" %>

<c:set var="page" value="${jcr:getParentOfType(currentNode, 'jnt:page')}"/>
<c:url value="${page.url}" var="cancelUrl"/>

<div class="well span6" style="float:none;margin:0 auto">
    <p class="text-error">Vos changements seront perdus, &ecirc;tes-vous s&ucirc;r de vouloir annuler?</p>

    <div class="pull-right">
        <a class="btn btn-danger" href="${cancelUrl}"
           title="Revenir sur mes informations en perdant les modifications">Je confirme!</a>
    </div>
</div>
