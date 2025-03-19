<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Edit Film | Cinema Hub</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
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
                        <i class="fas fa-film"></i> Cinema Hub
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
        <!-- Page Header -->
        <div class="mb-8">
            <div class="flex items-center gap-2">
                <a href="${pageContext.request.contextPath}/films" class="text-primary-600 hover:text-primary-700">
                    <i class="fas fa-arrow-left"></i>
                </a>
                <div>
                    <h1 class="text-3xl font-bold text-gray-900">Edit Film</h1>
                    <p class="mt-1 text-sm text-gray-600">Update the details of the film</p>
                </div>
            </div>
        </div>

        <!-- Form Card -->
        <div class="bg-white shadow-lg rounded-lg overflow-hidden max-w-4xl mx-auto">
            <div class="border-b border-gray-200 px-6 py-4 bg-gray-50">
                <h2 class="text-xl font-semibold text-gray-800 flex items-center gap-2">
                    <i class="fas fa-edit text-primary-600"></i> Film Information
                </h2>
            </div>
            
            <form action="${pageContext.request.contextPath}/modifier-film" method="post" class="p-6 space-y-6">
                <input type="hidden" name="id" value="${film.id}">

                <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                    <!-- Title Field -->
                    <div class="col-span-2">
                        <label for="titre" class="block text-sm font-medium text-gray-700 mb-1">
                            Film Title <span class="text-red-500">*</span>
                        </label>
                        <div class="relative">
                            <div class="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none">
                                <i class="fas fa-heading text-gray-400"></i>
                            </div>
                            <input type="text" name="titre" id="titre" value="${film.titre}" required
                                class="pl-10 block w-full h-10 rounded-md border border-gray-300 shadow-sm focus:ring-primary-500 focus:border-primary-500 sm:text-sm"
                                placeholder="Enter film title">
                        </div>
                    </div>

                    <!-- Description Field -->
                    <div class="col-span-2">
                        <label for="description" class="block text-sm font-medium text-gray-700 mb-1">
                            Description <span class="text-red-500">*</span>
                        </label>
                        <div class="relative">
                            <div class="absolute top-3 left-3 pointer-events-none">
                                <i class="fas fa-align-left text-gray-400"></i>
                            </div>
                            <textarea name="description" id="description" rows="4" required
                                class="pl-10 block w-full rounded-md border border-gray-300 shadow-sm focus:ring-primary-500 focus:border-primary-500 sm:text-sm py-2"
                                placeholder="Enter film description">${film.description}</textarea>
                        </div>
                    </div>

                    <!-- Genre Field -->
                    <div>
                        <label for="genre" class="block text-sm font-medium text-gray-700 mb-1">
                            Genre <span class="text-red-500">*</span>
                        </label>
                        <div class="relative">
                            <div class="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none">
                                <i class="fas fa-tag text-gray-400"></i>
                            </div>
                            <input type="text" name="genre" id="genre" value="${film.genre}" required
                                class="pl-10 block w-full h-10 rounded-md border border-gray-300 shadow-sm focus:ring-primary-500 focus:border-primary-500 sm:text-sm"
                                placeholder="e.g., Action, Drama, Comedy">
                        </div>
                    </div>

                    <!-- Release Year Field -->
                    <div>
                        <label for="anneeSortie" class="block text-sm font-medium text-gray-700 mb-1">
                            Release Year <span class="text-red-500">*</span>
                        </label>
                        <div class="relative">
                            <div class="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none">
                                <i class="fas fa-calendar-alt text-gray-400"></i>
                            </div>
                            <input type="number" name="anneeSortie" id="anneeSortie" value="${film.anneeSortie}" required
                                class="pl-10 block w-full h-10 rounded-md border border-gray-300 shadow-sm focus:ring-primary-500 focus:border-primary-500 sm:text-sm"
                                placeholder="e.g., 2023" min="1900" max="2030">
                        </div>
                    </div>

                    <!-- Poster URL Field -->
                    <div class="col-span-2">
                        <label for="poster" class="block text-sm font-medium text-gray-700 mb-1">
                            Poster URL
                        </label>
                        <div class="relative">
                            <div class="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none">
                                <i class="fas fa-image text-gray-400"></i>
                            </div>
                            <input type="text" name="poster" id="poster" value="${film.poster}"
                                class="pl-10 block w-full h-10 rounded-md border border-gray-300 shadow-sm focus:ring-primary-500 focus:border-primary-500 sm:text-sm"
                                placeholder="Enter URL to film poster image">
                        </div>
                        <p class="mt-1 text-xs text-gray-500">Leave empty for a placeholder image</p>
                    </div>

                    <!-- Director Field -->
                    <div>
                        <label for="realisateurId" class="block text-sm font-medium text-gray-700 mb-1">
                            Director <span class="text-red-500">*</span>
                        </label>
                        <div class="relative">
                            <div class="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none">
                                <i class="fas fa-user-tie text-gray-400"></i>
                            </div>
                            <select name="realisateurId" id="realisateurId" required
                                class="pl-10 block w-full h-10 rounded-md border border-gray-300 shadow-sm focus:ring-primary-500 focus:border-primary-500 sm:text-sm appearance-none"
                                style="padding-top: 0; padding-bottom: 0;">
                                <option value="" disabled>Select a director</option>
                                <c:forEach var="realisateur" items="${realisateurs}">
                                    <option value="${realisateur.id}" ${realisateur.id == film.realisateurId ? 'selected' : ''}>${realisateur.nom} ${realisateur.prenom}</option>
                                </c:forEach>
                            </select>
                            <div class="absolute inset-y-0 right-0 flex items-center pr-3 pointer-events-none">
                                <i class="fas fa-chevron-down text-gray-400"></i>
                            </div>
                        </div>
                        <p class="mt-1 text-xs text-gray-500 flex items-center">
                            <a href="#" class="text-primary-600 hover:text-primary-700 inline-flex items-center">
                               
                            </a>
                        </p>
                    </div>

                    <!-- Actors Field -->
                    <div>
                        <label for="acteurIds" class="block text-sm font-medium text-gray-700 mb-1">
                            Actors
                        </label>
                        <div class="relative">
                            <div class="absolute top-3 left-3 pointer-events-none">
                                <i class="fas fa-users text-gray-400"></i>
                            </div>
                            <select name="acteurIds" id="acteurIds" multiple
                                class="pl-10 block w-full rounded-md border border-gray-300 shadow-sm focus:ring-primary-500 focus:border-primary-500 sm:text-sm py-2"
                                size="5">
                                <c:forEach var="acteur" items="${acteurs}">
                                    <option value="${acteur.id}" ${selectedActeurIds.contains(acteur.id) ? 'selected' : ''}>${acteur.nom} ${acteur.prenom}</option>
                                </c:forEach>
                            </select>
                        </div>
                        <p class="mt-1 text-xs text-gray-500">Hold Ctrl/Cmd to select multiple actors</p>
                    </div>
                </div>

                <div class="border-t border-gray-200 pt-6 flex justify-between items-center">
                    <div class="text-xs text-gray-500">Fields marked with <span class="text-red-500">*</span> are required</div>
                    <div class="flex space-x-3">
                        <a href="${pageContext.request.contextPath}/films" 
                            class="inline-flex justify-center py-2 px-4 border border-gray-300 shadow-sm text-sm font-medium rounded-md text-gray-700 bg-white hover:bg-gray-50 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-primary-500">
                            Cancel
                        </a>
                        <button type="submit" 
                            class="inline-flex justify-center py-2 px-4 border border-transparent shadow-sm text-sm font-medium rounded-md text-white bg-primary-600 hover:bg-primary-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-primary-500">
                            <i class="fas fa-save mr-2"></i> Update Film
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
                    <p class="text-sm">© 2025 MovieF. All rights reserved.</p>
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