<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Liste des Réalisateurs | MovieR</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">
    <script>
        tailwind.config = {
            theme: {
                extend: {
                    colors: {
                        primary: {
                            50: '#f0f9ff',
                            100: '#e0f2fe',
                            200: '#bae6fd',
                            300: '#7dd3fc',
                            400: '#38bdf8',
                            500: '#0ea5e9',
                            600: '#0284c7',
                            700: '#0369a1',
                            800: '#075985',
                            900: '#0c4a6e',
                        },
                    },
                    fontFamily: {
                        sans: ['Inter', 'sans-serif'],
                    },
                }
            }
        }
    </script>
</head>
<body class="bg-gray-50 font-sans text-gray-800">
    
    <nav class="bg-primary-700 text-white shadow-lg">
        <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
            <div class="flex justify-between h-16">
                <div class="flex items-center">
                    <span class="text-xl font-bold flex items-center gap-2">
                        <i class="fas fa-film"></i> MovieR
                    </span>
                </div>
                <div class="flex items-center">
                    <a href="<%= request.getContextPath() %>/index.jsp" class="px-3 py-2 rounded-md text-sm font-medium hover:bg-primary-600">Dashboard</a>
                    <a href="films" class="px-3 py-2 rounded-md text-sm font-medium hover:bg-primary-600">Films</a>
                    <a href="acteurs" class="px-3 py-2 rounded-md text-sm font-medium hover:bg-primary-600">Acteurs</a>
                    <a href="realisateurs" class="px-3 py-2 rounded-md text-sm font-medium hover:bg-primary-600">Realisateurs</a>
                </div>
            </div>
        </div>
    </nav>

   
    <div class="max-w-7xl mx-auto py-8 px-4 sm:px-6 lg:px-8">
        
        <div class="mb-8">
            <div class="flex justify-between items-center">
                <div>
                    <h1 class="text-3xl font-bold text-gray-900">Liste des Réalisateurs</h1>
                    <p class="mt-1 text-sm text-gray-600">Gérez les réalisateurs de votre collection.</p>
                </div>
                <div class="flex items-center gap-4">
                    <div class="relative">
                        <input type="text" placeholder="Rechercher des réalisateurs..." class="pl-10 pr-4 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-primary-500 focus:border-primary-500 w-64">
                        <div class="absolute left-3 top-2.5 text-gray-400">
                            <i class="fas fa-search"></i>
                        </div>
                    </div>
                    <a href="${pageContext.request.contextPath}/views/realisateurs/add.jsp" 
                        class="flex items-center gap-2 bg-primary-600 text-white px-4 py-2 rounded-lg shadow-md hover:bg-primary-700 transition duration-300 font-medium">
                        <i class="fas fa-plus"></i> Ajouter un Réalisateur
                    </a>
                </div>
            </div>
        </div>

       
        <div class="grid grid-cols-1 md:grid-cols-3 gap-6 mb-8">
            <div class="bg-white rounded-lg shadow p-6 border-l-4 border-blue-500">
                <div class="flex items-center">
                    <div class="bg-blue-100 p-3 rounded-full">
                        <i class="fas fa-user-tie text-blue-500"></i>
                    </div>
                    <div class="ml-4">
                        <h3 class="text-sm font-medium text-gray-500">Total Réalisateurs</h3>
                        <p class="text-2xl font-semibold"><c:out value="${realisateurs.size()}"/></p>
                    </div>
                </div>
            </div>
            <div class="bg-white rounded-lg shadow p-6 border-l-4 border-purple-500">
                <div class="flex items-center">
                    <div class="bg-purple-100 p-3 rounded-full">
                        <i class="fas fa-film text-purple-500"></i>
                    </div>
                    <div class="ml-4">
                        <h3 class="text-sm font-medium text-gray-500">Films Associés</h3>
                        <p class="text-2xl font-semibold">${films.size()}</p>
                    </div>
                </div>
            </div>
            <div class="bg-white rounded-lg shadow p-6 border-l-4 border-amber-500">
                <div class="flex items-center">
                    <div class="bg-amber-100 p-3 rounded-full">
                        <i class="fas fa-globe text-amber-500"></i>
                    </div>
                    <div class="ml-4">
                        <h3 class="text-sm font-medium text-gray-500">Nationalités</h3>
                        <p class="text-2xl font-semibold">${nationalities.size()}</p>
                    </div>
                </div>
            </div>
        </div>

       
        <div class="bg-white shadow-lg rounded-lg overflow-hidden">
            <div class="border-b border-gray-200 px-6 py-4 bg-gray-50 flex justify-between items-center">
                <h2 class="text-xl font-semibold text-gray-800">Table des Réalisateurs</h2>
            </div>
            
            <div class="overflow-x-auto">
                <table class="w-full border-collapse">
                    <thead class="bg-gray-100 text-gray-700 text-left text-sm uppercase font-semibold tracking-wider">
                        <tr>
                            <th class="py-3 px-4 border-b border-gray-200">ID</th>
                            <th class="py-3 px-4 border-b border-gray-200">Nom</th>
                            <th class="py-3 px-4 border-b border-gray-200">Prénom</th>
                            <th class="py-3 px-4 border-b border-gray-200">Nationalité</th>
                            <th class="py-3 px-4 border-b border-gray-200 text-center">Actions</th>
                        </tr>
                    </thead>
                    <tbody class="divide-y divide-gray-200">
                        <c:choose>
                            <c:when test="${empty realisateurs}">
                                <tr>
                                    <td colspan="5" class="py-6 px-4 text-center text-gray-600">Aucun réalisateur n'existe actuellement.</td>
                                </tr>
                            </c:when>
                            <c:otherwise>
                                <c:forEach var="realisateur" items="${realisateurs}">
                                    <tr class="hover:bg-gray-50 transition text-sm">
                                        <td class="py-3 px-4 border-b border-gray-200">${realisateur.id}</td>
                                        <td class="py-3 px-4 border-b border-gray-200 font-medium">${realisateur.nom}</td>
                                        <td class="py-3 px-4 border-b border-gray-200">${realisateur.prenom}</td>
                                        <td class="py-3 px-4 border-b border-gray-200">
                                            <span class="px-2 py-1 bg-blue-100 text-blue-800 rounded-full text-xs font-medium">
                                                ${realisateur.nationalite}
                                            </span>
                                        </td>
                                        <td class="py-3 px-4 border-b border-gray-200">
                                            <div class="flex justify-center space-x-2">
                                                <a href="${pageContext.request.contextPath}/modifier-realisateur?id=${realisateur.id}"
                                                    class="bg-amber-500 text-white px-2 py-1 rounded shadow hover:bg-amber-600 transition duration-300 flex items-center gap-1 text-sm">
                                                    <i class="fas fa-edit"></i> Modifier
                                                </a>
                                                <a href="${pageContext.request.contextPath}/supprimer-realisateur?id=${realisateur.id}"
                                                    class="bg-red-500 text-white px-2 py-1 rounded shadow hover:bg-red-600 transition duration-300 flex items-center gap-1 text-sm"
                                                    onclick="return confirm('Êtes-vous sûr de vouloir supprimer ce réalisateur ?');">
                                                    <i class="fas fa-trash-alt"></i> Supprimer
                                                </a>
                                            </div>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </c:otherwise>
                        </c:choose>
                    </tbody>
                </table>
            </div>
        </div>
    </div>

    
    <footer class="bg-gray-800 text-white mt-12">
        <div class="max-w-7xl mx-auto py-6 px-4 sm:px-6 lg:px-8">
            <div class="flex flex-col md:flex-row justify-between items-center">
                <div class="mb-4 md:mb-0">
                    <p class="text-sm">© 2025 MovieR. All rights reserved.</p>
                </div>
                <div class="flex space-x-6">
                    <a href="#" class="text-gray-400 hover:text-white">
                        <i class="fab fa-github"></i>
                    </a>
                </div>
            </div>
        </div>
    </footer>
</body>
</html>