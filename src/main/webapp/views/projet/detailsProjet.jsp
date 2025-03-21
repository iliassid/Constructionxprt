// /WEB-INF/views/projet/detailsProjet.jsp
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<c:import url="/includes/header.jsp" />

<div class="container mt-5">
    <h1>Détails du Projet</h1>

    <div class="card">
        <div class="card-body">
            <h5 class="card-title">${projet.nom}</h5>
            <p class="card-text"><strong>Description:</strong> ${projet.description}</p>
            <p class="card-text"><strong>Date de Début:</strong> <fmt:formatDate value="${projet.dateDebut}" pattern="dd/MM/yyyy" /></p>
            <p class="card-text"><strong>Date de Fin:</strong> <fmt:formatDate value="${projet.dateFin}" pattern="dd/MM/yyyy" /></p>
            <p class="card-text"><strong>Budget:</strong> <fmt:formatNumber value="${projet.budget}" type="currency" currencySymbol="€" /></p>
            <p class="card-text"><strong>Statut:</strong> ${projet.statut}</p>
            <p class="card-text"><strong>Administrateur ID:</strong> ${projet.administrateurId}</p>
        </div>
    </div>

    <a href="${pageContext.request.contextPath}/projets" class="btn btn-secondary mt-3">Retour à la liste</a>
</div>

<c:import url="/includes/footer.jsp" />