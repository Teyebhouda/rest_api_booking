<script setup>
import { ref } from "vue"


const projects = ref([
  {
    id: 1,
    title: "Construction Villa Moderne",
    description: "Villa haut standing avec design contemporain et finitions de luxe.",
    location: "Paris, France",
    date: "2025-05-10",
    image: "https://images.unsplash.com/photo-1505691938895-1758d7feb511?auto=format&fit=crop&w=800&q=80",
  },
  {
    id: 2,
    title: "Immeuble Résidentiel",
    description: "Un projet immobilier de 20 appartements avec parking et espaces verts.",
    location: "Lyon, France",
    date: "2025-04-22",
    image: "https://images.unsplash.com/photo-1600607687920-4e2a7d8b3b3b?auto=format&fit=crop&w=800&q=80",
  },
  {
    id: 3,
    title: "Rénovation Bureau",
    description: "Transformation d'un ancien entrepôt en bureaux modernes et lumineux.",
    location: "Marseille, France",
    date: "2025-02-15",
    image: "https://images.unsplash.com/photo-1560448204-e02f11c3d0e2?auto=format&fit=crop&w=800&q=80",
  },
])
</script>

<template>
  <section class="bg-gray-50 py-20 px-6 md:px-16 lg:px-24">
    <div class="max-w-7xl mx-auto">
      <!-- Titre Section -->
      <div class="text-center mb-16">
        <h2 class="text-4xl md:text-5xl font-extrabold text-gray-900 mb-4 tracking-tight">
          Nos Réalisations
        </h2>
        <p class="text-lg text-gray-600 max-w-2xl mx-auto">
          Découvrez quelques-uns de nos projets récents alliant modernité, qualité et expertise.
        </p>
      </div>

      <!-- Grille des projets -->
      <div class="grid md:grid-cols-2 lg:grid-cols-3 gap-10">
        <div
          v-for="project in projects"
          :key="project.id"
          class="group bg-white rounded-2xl shadow-lg overflow-hidden hover:shadow-2xl transition duration-500"
        >
          <!-- Image -->
          <div class="relative h-64 overflow-hidden">
            <img
              :src="project.image"
              :alt="project.title"
              class="w-full h-full object-cover group-hover:scale-110 transition duration-500"
            />
            <div class="absolute inset-0 bg-black/40 opacity-0 group-hover:opacity-100 transition duration-500 flex items-center justify-center">
              <span class="text-white text-lg font-semibold">Voir plus</span>
            </div>
          </div>

          <!-- Contenu -->
          <div class="p-6">
            <h3 class="text-2xl font-bold text-gray-800 mb-2 group-hover:text-blue-600 transition">
              {{ project.title }}
            </h3>
            <p class="text-gray-600 mb-4 line-clamp-2">{{ project.description }}</p>

            <div class="flex items-center justify-between text-sm text-gray-500">
              <span>📍 {{ project.location }}</span>
              <span>📅 {{ new Date(project.date).toLocaleDateString("fr-FR") }}</span>
            </div>
          </div>
        </div>
      </div>

      <!-- Bouton -->
      <div class="text-center mt-12">
        <a
          href="#"
          class="inline-block bg-blue-600 text-white px-8 py-3 rounded-full font-semibold shadow-lg hover:bg-blue-700 transition transform hover:-translate-y-1"
        >
          Voir tous les projets
        </a>
      </div>
    </div>
  </section>
</template>
