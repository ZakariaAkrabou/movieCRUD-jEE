<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Ajouter un Acteur | MovieR</title>
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
    <!-- Navigation Bar -->
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

    <!-- Main Content -->
    <div class="max-w-7xl mx-auto py-8 px-4 sm:px-6 lg:px-8">
        <!-- Page Header -->
        <div class="mb-8">
            <div class="flex items-center gap-2">
                <a href="${pageContext.request.contextPath}/acteurs" class="text-primary-600 hover:text-primary-700">
                    <i class="fas fa-arrow-left"></i>
                </a>
                <div>
                    <h1 class="text-3xl font-bold text-gray-900">Ajouter un Acteur</h1>
                    <p class="mt-1 text-sm text-gray-600">Remplissez les détails pour ajouter un nouvel acteur.</p>
                </div>
            </div>
        </div>

        <!-- Form Card -->
        <div class="bg-white shadow-lg rounded-lg overflow-hidden max-w-4xl mx-auto">
            <div class="border-b border-gray-200 px-6 py-4 bg-gray-50">
                <h2 class="text-xl font-semibold text-gray-800 flex items-center gap-2">
                    <i class="fas fa-plus-circle text-primary-600"></i> Informations de l'Acteur
                </h2>
            </div>
            
            <form action="${pageContext.request.contextPath}/ajouter-acteur" method="post" class="p-6 space-y-6">
                <c:if test="${not empty erreur}">
                    <div class="bg-red-500 text-white p-2 rounded-md mb-4">
                        ${erreur}
                    </div>
                </c:if>

                <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                    <!-- Nom Field -->
                    <div>
                        <label for="nom" class="block text-sm font-medium text-gray-700 mb-1">
                            Nom <span class="text-red-500">*</span>
                        </label>
                        <div class="relative">
                            <div class="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none">
                                <i class="fas fa-user text-gray-400"></i>
                            </div>
                            <input type="text" name="nom" id="nom" required
                                class="pl-10 block w-full h-10 rounded-md border border-gray-300 shadow-sm focus:ring-primary-500 focus:border-primary-500 sm:text-sm"
                                placeholder="Entrez le nom de l'acteur">
                        </div>
                    </div>

                    <!-- Prénom Field -->
                    <div>
                        <label for="prenom" class="block text-sm font-medium text-gray-700 mb-1">
                            Prénom <span class="text-red-500">*</span>
                        </label>
                        <div class="relative">
                            <div class="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none">
                                <i class="fas fa-user text-gray-400"></i>
                            </div>
                            <input type="text" name="prenom" id="prenom" required
                                class="pl-10 block w-full h-10 rounded-md border border-gray-300 shadow-sm focus:ring-primary-500 focus:border-primary-500 sm:text-sm"
                                placeholder="Entrez le prénom de l'acteur">
                        </div>
                    </div>

                    
                    <div class="col-span-2">
                        <label for="nationalite" class="block text-sm font-medium text-gray-700 mb-1">
                            Nationalité <span class="text-red-500">*</span>
                        </label>
                        <div class="relative">
                            <div class="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none">
                                <i class="fas fa-globe text-gray-400"></i>
                            </div>
                            <input type="text" name="nationalite" id="nationalite" required
                                class="pl-10 block w-full h-10 rounded-md border border-gray-300 shadow-sm focus:ring-primary-500 focus:border-primary-500 sm:text-sm"
                                placeholder="Entrez la nationalité de l'acteur">
                        </div>
                    </div>
                </div>

                <div class="border-t border-gray-200 pt-6 flex justify-between items-center">
                    <div class="text-xs text-gray-500">Les champs marqués avec <span class="text-red-500">*</span> sont obligatoires</div>
                    <div class="flex space-x-3">
                        <a href="${pageContext.request.contextPath}/acteurs" 
                            class="inline-flex justify-center py-2 px-4 border border-gray-300 shadow-sm text-sm font-medium rounded-md text-gray-700 bg-white hover:bg-gray-50 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-primary-500">
                            Annuler
                        </a>
                        <button type="submit" 
                            class="inline-flex justify-center py-2 px-4 border border-transparent shadow-sm text-sm font-medium rounded-md text-white bg-primary-600 hover:bg-primary-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-primary-500">
                            <i class="fas fa-save mr-2"></i> Ajouter
                        </button>
                    </div>
                </div>
            </form>
        </div>
    </div>

    <!-- Footer -->
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