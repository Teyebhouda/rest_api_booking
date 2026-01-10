<script setup>
import Navbar from './Components/Navbar.vue'
import Contat_form from './Components/Contact_form.vue'
import { usePage } from '@inertiajs/vue3'
import Footer from './Components/Footer.vue'
import { computed } from 'vue'

defineProps({
  service: Object
})

const page = usePage()
const contactContent = computed(() => page.props.sections?.footer?.content || {})
const services = computed(() => page.props.sections?.services?.content?.items || [])

</script>

<template>
  <div class="min-h-screen flex flex-col text-gray-800">
    <!-- Header -->
    <Navbar />
    <br />
    <br />
    <br />

    <!-- Contenu principal -->
    <main class="flex-1">
      
      <!-- Détail du service -->
      <section class="bg-white py-24 px-4 md:px-12 lg:px-24">
        
        <div class="max-w-6xl mx-auto grid grid-cols-1 md:grid-cols-2 gap-12 items-center">
          <!-- Texte -->
          <div>
            <h1 class="text-4xl md:text-5xl font-bold text-[#1B2B50] mb-6 leading-tight">
              {{ service.title }}
            </h1>
            <p class="text-lg text-gray-700 leading-relaxed">
              {{ service.description }}
            </p>
             <div
            class="prose max-w-none text-gray-800 prose-headings:text-[#1B2B50]"
            v-if="service.long_description"
            v-html="service.long_description"
          ></div>

            <!-- Bouton vers formulaire -->
            <a href="#contact-form" class="inline-block mt-8 px-6 py-3 bg-[#1B2B50] text-white rounded-lg shadow hover:bg-[#2a3c6b] transition">
              Demander un devis
            </a>
          </div>

          <!-- Icône / Image -->
         <div class="flex justify-center md:justify-end">
  <!-- Image statique symbolique à la place de l'icône dynamique -->
   
  <img
  :src="service.background_image || '/images/worker-silhouette.png'"
  :alt="`Illustration pour ${service.title}`"
    class="w-full h-64 md:h-96 object-cover rounded-xl shadow-lg"
            loading="lazy"
   
  />
</div>

        </div>
      </section>

      <!-- Formulaire de contact -->
<Contat_form
  id="contact-form"
  :content="contactContent"
  :initialService="service.title"
  :services="services"
/>
    </main>
  </div>
   <Footer />
</template>
