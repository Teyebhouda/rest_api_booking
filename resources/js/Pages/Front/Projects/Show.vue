<script setup>
import { computed , ref } from 'vue'
import Navbar from '../Components/Navbar.vue'
import Footer from '../Components/Footer.vue'
import Contat_form from '../Components/Contact_form.vue'
import { usePage } from '@inertiajs/vue3'
const props = defineProps({
  project: Object,
  projectsData: {
    type: Array,
    default: () => []
  }
})
const page = usePage()
const contactContent = computed(() => page.props.sections?.footer?.content || {})
const projects = ref(props.projectsData)
const services = computed(() => page.props.sections?.services?.content?.items || [])
const footerContent = computed(() => page.props.sections?.footer?.content || {})

console.log('projectsdata', projects.value)
const images = computed(() => props.project.images || [])

</script>

<template> 
   <div class="min-h-screen flex flex-col text-gray-800">
    <Navbar :projects="projects" />
    <br />
    <br />
    <br />
    <br />  
    
    <!-- Section principale du projet -->
      <main class="flex-1">
  <section class="bg-white py-20 px-4 md:px-12 min-h-screen">
    <div class="max-w-5xl mx-auto grid md:grid-cols-2 gap-12 items-start">
      <!-- Images du projet -->
      <div>
        <div class="flex flex-wrap gap-4">
          <img
            v-for="img in images"
            :key="img.id"
            :src="`/storage/${img.path}`"
            alt="Image projet"
            class="rounded-lg shadow-lg w-full md:w-64 h-48 object-cover transition-transform duration-300 hover:scale-105"
          />
        </div>
      </div>
      <!-- Détails du projet -->
      <div>
        <h1 class="text-4xl font-extrabold text-gray-900 mb-4">{{ project.title }}</h1>
        <div class="mb-4 text-gray-600 text-lg">
          <span v-if="project.location" class="inline-flex items-center gap-2">
            <svg class="w-5 h-5 text-blue-500" fill="none" stroke="currentColor" viewBox="0 0 24 24">
              <path stroke-width="2" d="M12 2C8.13 2 5 5.13 5 9c0 5.25 7 13 7 13s7-7.75 7-13c0-3.87-3.13-7-7-7z"/>
              <circle cx="12" cy="9" r="2.5" />
            </svg>
            {{ project.location }}
          </span>
          <span v-if="project.date" class="ml-4">
            <svg class="w-5 h-5 text-blue-500 inline" fill="none" stroke="currentColor" viewBox="0 0 24 24">
              <path stroke-width="2" d="M8 7V3M16 7V3M4 11h16M4 19h16M4 15h16"/>
            </svg>
            {{ new Date(project.date).toLocaleDateString() }}
          </span>
        </div>
        <div class="prose max-w-none mb-6" v-if="project.description">
          {{ project.description }}
        </div>
        <div class="prose max-w-none mb-6" v-if="project.content">
          <div v-html="project.content"></div>
        </div>
        <div class="mt-8 flex gap-4">
          <a :href="`/contact`" class="px-6 py-3 bg-primary text-white font-semibold rounded-xl shadow-md hover:bg-primary/90 hover:-translate-y-1 hover:shadow-lg transition transform duration-300 focus:outline-none focus:ring-2 focus:ring-primary/70">Contactez-nous</a>
          <a href="/projects" class="bg-gray-100 text-gray-700 px-6 py-2 rounded-lg shadow hover:bg-gray-200 transition">Voir plus de projets</a>
        </div>
      </div>
    </div>
  </section>
      <!-- Formulaire de contact -->
<Contat_form
  id="contact-form"
  :content="contactContent"
  :services="services"
/>
    
      </main>
    <!-- Footer -->
    <Footer :content="footerContent" />
  </div>
</template>

<style scoped>
.prose {
  font-size: 1.1rem;
  color: #374151;
}
</style>