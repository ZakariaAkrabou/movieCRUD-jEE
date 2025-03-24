<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Film Library | Management Dashboard</title>
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
   
    <nav class="bg-primary-700 text-white shadow-lg">
        <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
            <div class="flex justify-between h-16">
                <div class="flex items-center">
                    <span class="text-xl font-bold flex items-center gap-2">
                        <i class="fas fa-film"></i> MovieF
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
            <div class="flex justify-between items-center">
                <div>
                    <h1 class="text-3xl font-bold text-gray-900">Film List</h1>
                    <p class="mt-1 text-sm text-gray-600">Manage your film </p>
                </div>
                <div class="flex items-center gap-4">
                    <div class="relative">
                        <input type="text" placeholder="Search films..." class="pl-10 pr-4 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-primary-500 focus:border-primary-500 w-64">
                        <div class="absolute left-3 top-2.5 text-gray-400">
                            <i class="fas fa-search"></i>
                        </div>
                    </div>
                    <a href="${pageContext.request.contextPath}/ajouter-film" 
                        class="flex items-center gap-2 bg-primary-600 text-white px-4 py-2 rounded-lg shadow-md hover:bg-primary-700 transition duration-300 font-medium">
                        <i class="fas fa-plus"></i> Add New Film
                    </a>
                </div>
            </div>
        </div>

       
        <div class="grid grid-cols-1 md:grid-cols-4 gap-6 mb-8 ">
            <div class="bg-white rounded-lg shadow p-6 border-l-4 border-blue-500 ">
                <div class="flex items-center">
                    <div class="bg-blue-100 p-3 rounded-full">
                        <i class="fas fa-film text-blue-500"></i>
                    </div>
                    <div class="ml-4">
                        <h3 class="text-sm font-medium text-gray-500">Total Films</h3>
                        <p class="text-2xl font-semibold"><c:out value="${films.size()}"/></p>
                    </div>
                </div>
            </div>
            
            <div class="bg-white rounded-lg shadow p-6 border-l-4 border-purple-500">
                <div class="flex items-center">
                    <div class="bg-purple-100 p-3 rounded-full">
                        <i class="fas fa-user-tie text-purple-500"></i>
                    </div>
                    <div class="ml-4">
                        <h3 class="text-sm font-medium text-gray-500">Acteurs</h3>
                        <p class="text-2xl font-semibold">8</p>
                        
                        
                    </div>
                </div>
            </div>
            <div class="bg-white rounded-lg shadow p-6 border-l-4 border-amber-500">
                <div class="flex items-center">
                    <div class="bg-amber-100 p-3 rounded-full">
                         <i class="fas fa-user-tie text-amber-500"></i>
                    </div>
                    <div class="ml-4">
                        <h3 class="text-sm font-medium text-gray-500">Realisateurs</h3>
                        <p class="text-2xl font-semibold">8</p>
                    </div>
                </div>
            </div>
        </div>

       
        <div class="bg-white shadow-lg rounded-lg overflow-hidden">
            <div class="border-b border-gray-200 px-6 py-4 bg-gray-50 flex justify-between items-center">
                <h2 class="text-xl font-semibold text-gray-800">Film Table</h2>
            </div>
            
            <div class="overflow-x-auto">
                <table class="w-full border-collapse">
                    <thead class="bg-gray-100 text-gray-700 text-left text-sm uppercase font-semibold tracking-wider">
                        <tr>
                           
                            <th class="py-3 px-4 border-b border-gray-200">Title</th>
                            <th class="py-3 px-4 border-b border-gray-200">Description</th>
                            <th class="py-3 px-4 border-b border-gray-200">Genre</th>
                            <th class="py-3 px-4 border-b border-gray-200">Release Year</th>
                            <th class="py-3 px-4 border-b border-gray-200">Poster</th>
                             <th class="py-3 px-4 border-b border-gray-200">Actors</th>
                            <th class="py-3 px-4 border-b border-gray-200">Director</th>
                            <th class="py-3 px-4 border-b border-gray-200 text-center">Actions</th>
                        </tr>
                    </thead>
                    <tbody class="divide-y divide-gray-200">
                        <c:forEach var="film" items="${films}">
                            <tr class="hover:bg-gray-50 transition text-sm">
                                
                                <td class="py-3 px-4 border-b border-gray-200 font-medium">${film.titre}</td>
                                <td class="py-3 px-4 border-b border-gray-200 max-w-xs truncate">${film.description}</td>
                                <td class="py-3 px-4 border-b border-gray-200">
                                    <span class="px-2 py-1 bg-blue-100 text-blue-800 rounded-full text-xs font-medium">
                                        ${film.genre}
                                    </span>
                                </td>
                                <td class="py-3 px-4 border-b border-gray-200 text-center">${film.anneeSortie}</td>
                                <td class="py-3 px-4 border-b border-gray-200">
                                    <img src="${film.poster}" alt="${film.titre}" class="w-20 h-12 object-cover rounded-md shadow-sm">
                                </td>
                                 <td class="py-3 px-4 border-b border-gray-200">
                    <div class="flex flex-wrap gap-1 max-w-xs">
                        <c:forEach var="acteur" items="${film.acteurs}">
                            <span class="px-2 py-1 bg-gray-100 text-gray-800 rounded-full text-xs">
                                ${acteur.prenom} ${acteur.nom}
                            </span>
                        </c:forEach>
                    </div>
                </td>
                                <td class="py-3 px-4 border-b border-gray-200">
                                    <span class="flex items-center gap-1">
                                        <i class="fas fa-user-tie text-gray-400"></i>
                                        ${film.realisateurId}
                                    </span>
                                </td>
                                <td class="py-3 px-4 border-b border-gray-200">
                                    <div class="flex justify-center space-x-2">
                                        <a href="${pageContext.request.contextPath}/modifier-film?id=${film.id}"
                                            class="bg-amber-500 text-white px-2 py-1 rounded shadow hover:bg-amber-600 transition duration-300 flex items-center gap-1 text-sm">
                                            <i class="fas fa-edit"></i> Edit
                                        </a>
                                        <a href="${pageContext.request.contextPath}/supprimer-film?id=${film.id}"
                                            class="bg-red-500 text-white px-2 py-1 rounded shadow hover:bg-red-600 transition duration-300 flex items-center gap-1 text-sm">
                                            <i class="fas fa-trash-alt"></i> Delete
                                        </a>
                                        
                                    </div>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
            
          
            
        </div>
    </div>


    <footer class="bg-gray-800 text-white mt-12">
        <div class="max-w-7xl mx-auto py-6 px-4 sm:px-6 lg:px-8">
            <div class="flex flex-col md:flex-row justify-between items-center">
                <div class="mb-4 md:mb-0">
                    <p class="text-sm">© 2025 Cinema Hub. All rights reserved.</p>
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