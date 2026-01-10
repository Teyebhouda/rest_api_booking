<!DOCTYPE html>
<html lang="{{ str_replace('_', '-', app()->getLocale()) }}">
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
         <meta name="csrf-token" content="{{ csrf_token() }}">
  <!-- <title inertia>{{ config('app.name', 'Laravel') }}</title> -->

     <title>{{ $page['props']['seo']['meta_title'] ?? $page['props']['settings']['meta_title'] ?? 'FSD-bâtiment  | Entreprise  de bâtiment | Travaux de construction et rénovation' }}</title>
<meta name="description" content="{{ $page['props']['seo']['meta_description'] ?? $page['props']['settings']['meta_description'] ?? 'Notre entreprise de bâtiment réalise vos travaux de construction, rénovation, plomberie, électricité et maçonnerie avec professionnalisme et qualité.' }}">
<meta name="keywords" content="{{ $page['props']['seo']['meta_keywords'] ?? $page['props']['settings']['meta_keywords'] ?? 'Fsd bâtiment, entreprise bâtiment, rénovation, construction, plomberie, électricité, maçonnerie, peinture, travaux bâtiment' }}">
 
        <!-- Fonts -->
         <link
  rel="stylesheet"
  href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css"
/>

        <link rel="preconnect" href="https://fonts.bunny.net">
        <link href="https://fonts.bunny.net/css?family=figtree:400,500,600&display=swap" rel="stylesheet" />
       <link rel="preload" as="image" href="/images/homepage/eDBCCWWEqWNuSccyycJcIR35AeY9buD23grBdaB9.png">


          <!--favicon-->
<link rel="icon" type="image/png" href="/images/favicon/favicon-96x96.png" sizes="96x96" />
<link rel="icon" type="image/svg+xml" href="/images/favicon/favicon.svg" />
<link rel="shortcut icon" href="/images/favicon/favicon.ico" />
<link rel="apple-touch-icon" sizes="180x180" href="/favicon/apple-touch-icon.png" />
<link rel="manifest" href="/images/favicon/site.webmanifest" />

<!-- GSAP -->

<script src="https://cdn.jsdelivr.net/npm/gsap@3.12.2/dist/gsap.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/gsap@3.12.2/dist/ScrollTrigger.min.js"></script>


<!-- Exemple avec Inter -->
<link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;600;800&display=swap" rel="stylesheet">

        <!-- Scripts -->
        @routes
        @vite(['resources/js/app.js', "resources/js/Pages/{$page['component']}.vue"])
        @inertiaHead
    </head>
    <body class="font-sans antialiased">
        @inertia
    </body>
</html>
<style>
  /* Styles globaux */
  body {
    font-family: 'Inter', sans-serif;
   
 


  }
