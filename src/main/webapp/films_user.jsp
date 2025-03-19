<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Films Disponibles</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <style>
        .glowing-title {
            text-shadow: 0 0 10px #a855f7, 0 0 20px #9333ea, 0 0 30px #7e22ce;
        }
    </style>
</head>
<body class="bg-gray-900 text-white p-6">
    <div class="container mx-auto">
        <h1 class="text-4xl font-extrabold mb-10 text-center glowing-title flex items-center justify-center">
            <span class="mr-2">🎬</span> Films Disponibles
        </h1>
        
        <div class="grid grid-cols-1 sm:grid-cols-2 md:grid-cols-3 lg:grid-cols-4 gap-8">
            <c:forEach var="film" items="${films}">
                <div class="bg-gray-800 rounded-xl shadow-lg overflow-hidden transform transition-all hover:scale-105 hover:shadow-purple-500">
                    <img src="${film.poster}" alt="${film.titre}" class="w-full h-64 object-cover">
                    <div class="p-5">
                        <h2 class="text-lg font-bold text-white mb-1">${film.titre}</h2>
                        <p class="text-gray-400 text-sm italic">${film.anneeSortie}</p>
                        <p class="text-gray-300 text-sm mt-2 line-clamp-3">${film.description}</p>
                        <a href="#" class="inline-block mt-3 px-4 py-2 text-purple-500 border border-purple-500 rounded-md hover:bg-purple-500 hover:text-white transition">Voir détails</a>
                    </div>
                </div>
            </c:forEach>
        </div>
    </div>
</body>
</html>
