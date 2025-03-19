<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Movie Management | Cinema Hub</title>
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
                        <i class="fas fa-film"></i> Cinema Hub
                    </span>
                </div>
                <div class="flex items-center">
                    <a href="#" class="px-3 py-2 rounded-md text-sm font-medium hover:bg-primary-600">Dashboard</a>
                    <a href="${pageContext.request.contextPath}/films" class="px-3 py-2 rounded-md text-sm font-medium hover:bg-primary-600">Films</a>
                    <a href="#" class="px-3 py-2 rounded-md text-sm font-medium hover:bg-primary-600">Directors</a>
                    <a href="#" class="px-3 py-2 rounded-md text-sm font-medium hover:bg-primary-600">Reports</a>
                </div>
            </div>
        </div>
    </nav>

    <!-- Main Content -->
    <div class="max-w-7xl mx-auto py-8 px-4 sm:px-6 lg:px-8">
        <!-- Page Header -->
        <div class="mb-8">
            <h1 class="text-3xl font-bold text-gray-900">Movie Management (CRUD)</h1>
            <p class="mt-1 text-sm text-gray-600">Manage your films, directors, and actors with ease.</p>
        </div>

        <!-- Cards Grid -->
        <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
            <!-- Réalisateur Card -->
            <div class="bg-white rounded-lg shadow-lg p-6 border-l-4 border-blue-500">
                <h2 class="text-xl font-semibold text-gray-800 mb-4">Réalisateur</h2>
                <p class="text-sm text-gray-600 mb-4">Manage directors and their details.</p>
                <a href="realisateurs" class="inline-flex items-center justify-center px-4 py-2 bg-primary-600 text-white rounded-md hover:bg-primary-700 transition duration-300">
                    <i class="fas fa-arrow-right mr-2"></i> Go to Réalisateur
                </a>
            </div>

            <!-- Acteur Card -->
            <div class="bg-white rounded-lg shadow-lg p-6 border-l-4 border-purple-500">
                <h2 class="text-xl font-semibold text-gray-800 mb-4">Acteur</h2>
                <p class="text-sm text-gray-600 mb-4">Manage actors and their profiles.</p>
                <a href="acteurs" class="inline-flex items-center justify-center px-4 py-2 bg-primary-600 text-white rounded-md hover:bg-primary-700 transition duration-300">
                    <i class="fas fa-arrow-right mr-2"></i> Go to Acteur
                </a>
            </div>

            <!-- Films (Admin) Card -->
            <div class="bg-white rounded-lg shadow-lg p-6 border-l-4 border-green-500">
                <h2 class="text-xl font-semibold text-gray-800 mb-4">Films (Admin)</h2>
                <p class="text-sm text-gray-600 mb-4">Manage films with administrative privileges.</p>
                <a href="films" class="inline-flex items-center justify-center px-4 py-2 bg-primary-600 text-white rounded-md hover:bg-primary-700 transition duration-300">
                    <i class="fas fa-arrow-right mr-2"></i> Go to Films (Admin)
                </a>
            </div>

            <!-- Films (User) Card -->
            <div class="bg-white rounded-lg shadow-lg p-6 border-l-4 border-amber-500">
                <h2 class="text-xl font-semibold text-gray-800 mb-4">Films (User)</h2>
                <p class="text-sm text-gray-600 mb-4">View films as a regular user.</p>
                <a href="films-user" class="inline-flex items-center justify-center px-4 py-2 bg-primary-600 text-white rounded-md hover:bg-primary-700 transition duration-300">
                    <i class="fas fa-arrow-right mr-2"></i> Go to Films (User)
                </a>
            </div>
        </div>
    </div>

    <!-- Footer -->
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