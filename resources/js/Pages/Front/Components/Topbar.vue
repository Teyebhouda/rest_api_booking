<template>
  <header class="fixed top-0 left-0 w-full z-50 bg-white border-b shadow-sm">
    <!-- Ligne 1 : logo + hamburger (mobile) -->
    <div class="flex items-center justify-between px-4 py-3 md:py-4 md:px-16">
      <!-- Logo -->
      <img :src="$page.props.settings?.logo" alt="Logo" class="h-10 w-auto" />

      <!-- Desktop Menu -->
      <div class="hidden md:flex items-center gap-8 font-semibold text-gray-700 tracking-wide">
        <a href="/" class="hover:text-primary">Accueil</a>
        <Dropdown :items="services" title="Services" :slugify="slugify" />
        <Dropdown :items="projects" title="Projets" :slugify="slugify" />
        <a href="#contact-form" class="hover:text-primary">Contact</a>
        <a href="/about" class="hover:text-primary">À propos</a>
      </div>

      <!-- Hamburger (mobile only) -->
      <button @click="toggleMenu" class="md:hidden text-primary text-2xl">
        <i :class="isMenuOpen ? 'fas fa-times' : 'fas fa-bars'"></i>
      </button>
    </div>

    <!-- Ligne 2 : bouton mobile + desktop -->
    <div class="px-4 md:px-16 pb-3 md:pb-4">
      <!-- Mobile CTA button -->
      <a
        href="#contact-form"
        class="block md:hidden w-full text-center bg-gradient-to-r from-blue-600 to-blue-800 text-white py-3 rounded-lg font-semibold hover:from-blue-700 hover:to-blue-900 transition"
      >
        🚀 Demander un devis
      </a>

      <!-- Desktop CTA button -->
      <a
        href="#contact-form"
        class="hidden md:inline-block bg-primary text-white px-6 py-2.5 rounded-full font-semibold shadow hover:bg-primary/90 transition"
      >
        Demander un devis
      </a>
    </div>

    <!-- Menu Mobile Dropdown -->
    <transition name="fade-slide">
      <div
        v-if="isMenuOpen"
        class="md:hidden px-4 pb-4 flex flex-col gap-4 font-semibold text-gray-700"
      >
        <a href="/" class="hover:text-primary">Accueil</a>
        <MobileDropdown :items="services" title="Services" :slugify="slugify" />
        <MobileDropdown :items="projects" title="Projets" :slugify="slugify" />
        <a href="/about" class="hover:text-primary">À propos</a>
        <a href="#contact-form" class="hover:text-primary">Contact</a>
      </div>
    </transition>
  </header>
</template>

<script setup>
import { ref } from 'vue'
import Dropdown from './Dropdown.vue'
import MobileDropdown from './MobileDropdown.vue'

const props = defineProps({
  services: Array,
  projects: Array,
})

const isMenuOpen = ref(false)
const toggleMenu = () => {
  isMenuOpen.value = !isMenuOpen.value
}

const slugify = (text) =>
  text
    .toString()
    .normalize('NFD')
    .replace(/[\u0300-\u036f]/g, '')
    .toLowerCase()
    .replace(/\s+/g, '-')
    .replace(/[^\w-]+/g, '')
    .replace(/--+/g, '-')
    .replace(/^-+|-+$/g, '')
</script>

<style scoped>
.text-primary {
  color: #1363ab;
}

.fade-slide-enter-active,
.fade-slide-leave-active {
  transition: all 0.3s ease;
}
.fade-slide-enter-from,
.fade-slide-leave-to {
  transform: translateY(-10px);
  opacity: 0;
}
</style>
