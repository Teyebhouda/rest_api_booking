
<script setup>
import { computed } from 'vue'
import { usePage } from '@inertiajs/vue3'
import Navbar from './Components/Navbar.vue'
import Footer from './Components/Footer.vue'
import { defineProps } from 'vue'

const props = defineProps({
  page: Object
})
</script>
<template>
    <div class="min-h-screen flex flex-col text-gray-800">
    <!-- Header -->
    <Navbar />

    <!-- Contenu principal -->
    <main class="flex-1">
   
        <section class="bg-white py-24 px-4 md:px-12 lg:px-24">
        <div >
        <div>
          <h1 class="text-3xl font-bold mb-4">{{ page.title }}</h1>
            <div v-html="page.content" class="prose max-w-none"></div>
        </div>
        </div>
        </section>
    </main>
 
    <!-- Footer -->
    <Footer :footerPages="footerPages" />  
  </div>
</template>