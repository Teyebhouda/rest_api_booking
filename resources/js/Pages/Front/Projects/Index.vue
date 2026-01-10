<script setup>
import { ref } from 'vue'
import Navbar from '../Components/Navbar.vue'
import Footer from '../Components/Footer.vue'

const props = defineProps({
  projectsData: {
    type: Array,
    default: () => []
  }
})

const projects = ref(props.projectsData)
</script>

<template>
  <div class="min-h-screen flex flex-col text-gray-800">
    <!-- Navbar -->
    <Navbar :projects="projects" />
      <!-- Main Content -->
      <section class="py-12 bg-gray-100">

    <main class="flex-1 py-16 px-4 md:px-12">
      <h1 class="text-4xl font-bold mb-12 text-center">Nos Projets</h1>

      <div class="grid sm:grid-cols-2 lg:grid-cols-3 gap-8 max-w-6xl mx-auto">
        <div 
          v-for="project in projects" 
          :key="project.id"
          class="bg-white rounded-xl shadow-md hover:shadow-lg transition overflow-hidden"
        >
          <!-- Image principale -->
          <img 
            v-if="project.images && project.images.length"
            :src="`/storage/${project.images[0].path}`" 
            alt="Image projet"
            class="h-48 w-full object-cover"
          />

          <div class="p-6">
            <h2 class="text-xl font-semibold text-gray-800 mb-2">{{ project.title }}</h2>
            <p class="text-gray-600 line-clamp-3 mb-4">
              {{ project.description || 'Aucune description disponible.' }}
            </p>

            <a 
             :href="`/projects/${project.slug}`"
              class="text-blue-600 hover:underline font-medium"
            >
              Voir le projet →
            </a>
          </div>
        </div>
      </div>
    </main>
      </section>

    <!-- Footer -->
    <Footer />
  </div>
</template>

<style scoped>
.line-clamp-3 {
  display: -webkit-box;
  -webkit-line-clamp: 3;
  -webkit-box-orient: vertical;
  overflow: hidden;
}
</style>
