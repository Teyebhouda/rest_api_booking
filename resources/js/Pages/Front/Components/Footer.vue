
<script setup>

import { defineProps } from 'vue'

const props = defineProps({
  footerPages: Array, 
})


</script>
<template>
  <footer class="bg-primary-dark text-white py-6">
    <div class="container mx-auto flex flex-col items-center text-center">

      <!-- Navigation -->
      <nav class="flex flex-wrap justify-center gap-6 mb-3">
        <a
          v-for="page in footerPages"
          :key="page.id"
          :href="`/pages/${page.slug}`"
          class="text-gray-300 hover:text-white transition"
        >
          {{ page.title }}
        </a>
      </nav>

      <!-- Copyright -->
      <p class="text-gray-400 text-sm">
        © 2025 FSD BATIMENT — Tous droits réservés.
      </p>

    </div>
  </footer>
</template>


