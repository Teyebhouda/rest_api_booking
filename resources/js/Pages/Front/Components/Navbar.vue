<template> 
  <header class="sticky top-0 z-50 w-full">
    <!-- ✅ Topbar (hidden on mobile) -->
    <div
      class="topbar hidden md:block fixed top-0 left-0 w-full bg-white/80 backdrop-blur-md border-b border-gray-200 z-50 transition-all duration-300"
      :class="[isCompact ? 'py-2 h-18' : 'py-4 h-24']"
    >
      <div class="max-w-screen-xl mx-auto px-2 flex flex-col md:flex-row items-center justify-between gap-3 text-sm md:text-base">
        <!-- 🔹 Logo cliquable (desktop) -->
        <div class="flex items-center gap-3 cursor-pointer" @click="goHome">
          <img
            :src="$page.props.settings?.logo"
            alt="Logo"
            class="object-contain drop-shadow-sm transition-all duration-300"
            :class="isCompact ? 'h-10' : 'h-20'"
          />
        </div>

        <!-- Contact Info -->
        <div class="hidden md:flex flex-wrap gap-6 justify-end text-gray-600 text-xs md:text-sm">
          <div class="flex items-center gap-2">
            <i class="fas fa-envelope text-primary"></i>
            <a :href="`mailto:${$page.props.settings?.email}`" class="hover:text-primary font-medium">
              {{ $page.props.settings?.email }}
            </a>
          </div>
          <div class="flex items-center gap-2">
            <i class="fas fa-phone text-primary"></i>
            <a :href="`tel:${$page.props.settings?.phone}`" class="hover:text-primary font-medium">
              {{ $page.props.settings?.phone }}
            </a>
          </div>
          <div class="flex items-center gap-2">
            <i class="fas fa-map-marker-alt text-primary"></i>
            <span class="font-medium">{{ $page.props.settings?.adress }}</span>
          </div>
        </div>
      </div>
    </div>

    <!-- ✅ Navbar -->


<nav 
  class="navbar fixed w-full backdrop-blur-lg border-b shadow-sm transition-all duration-500"
  :class="[
    isHidden ? '-translate-y-full' : 'translate-y-0',
    isCompact ? 'md:top-14 top-0 scale-[0.97] opacity-95' : 'top-0 md:top-24 scale-100 opacity-100',
    isHome
      ? 'bg-white/70 border-white/20'
      : 'bg-white/90 border-gray-200'
  ]"
>


      <div class="max-w-screen-xl mx-auto px-2 py-5 md:py-3 flex flex-col gap-3 md:flex-row md:items-center md:justify-between">

        <!-- 🔹 Mobile: Logo + Hamburger -->
        <div class="flex w-full items-center justify-between md:hidden">
          <img
            :src="$page.props.settings?.logo"
            alt="Logo"
            class="h-14 object-contain cursor-pointer"
            @click="goHome"
          />
          <button
            @click="toggleMenu"
            class="text-primary text-4xl" 
            aria-label="Toggle menu"
          >
            <i :class="isMenuOpen ? 'fas fa-times' : 'fas fa-bars'"></i>
          </button>
        </div>

        <!-- Desktop Menu -->
       <div
  class="hidden md:flex items-center gap-8 font-semibold tracking-wide "
  :class="isHome ? 'text-gray-700' : 'text-gray-700'"
>

<a href="/" class="hover:text-primary transition">Accueil</a>
          <a href="#services-section" class="hover:text-primary transition" v-if="isHome">Services</a>
          <Dropdown :items="projects" title="Projets" :slugify="slugify"  v-if="isHome" />
          <a :href="`/contact`" class="hover:text-primary transition">Contact</a>
          <a href="#parallax-stats" class="hover:text-primary transition" v-if="isHome">À propos</a>
        </div>

        <!-- CTA Button -->
      <div class="w-full md:w-auto">

         <a
             href="#contact-form"
            class="block w-full text-center bg-gradient-to-r from-primary-light to-primary
             text-white py-3 rounded-lg font-semibold shadow-lg hover:from-blue-900 hover:to-primary-light   transition-all duration-300 md:inline-block md:py-2.5 md:px-6 "
          >
 
Devis gratuit
  </a>
</div>

      </div>

      <!-- ✅ Mobile Menu Dropdown -->
      <transition name="slide-fade">
        <div
          v-if="isMenuOpen"
          class="md:hidden bg-white/95 backdrop-blur-md shadow-lg px-6 py-6 flex flex-col gap-4 font-semibold text-gray-700"
        >
          <a href="/" class="hover:text-primary transition">Accueil</a>
          <a href="#services-section" class="hover:text-primary transition" v-if="isHome">Services</a>
          <MobileDropdown :items="projects" title="Projets" :slugify="slugify"  v-if="isHome" />
          <a :href="`/contact`" class="hover:text-primary transition">Contact</a>
          <a href="#parallax-stats" class="hover:text-primary transition" v-if="isHome">À propos</a>
        </div>
      </transition>
    </nav>
  </header>
</template>

<script setup>
import { Inertia } from '@inertiajs/inertia'
import Dropdown from './Dropdown.vue'
import MobileDropdown from './MobileDropdown.vue'
import { useScrollHide } from '@/useScrollHide'
import { ref, onMounted, onUnmounted } from 'vue'
const isHome = window.location.pathname === '/'

const props = defineProps({
  services: Array,
  projects: Array,
})

// 🔹 Fonction pour aller à la page d'accueil
const goHome = () => {
  if (window.location.pathname !== '/') {
    Inertia.visit('/')
  } else {
    window.scrollTo({ top: 0, behavior: 'smooth' })
  }
}



const isMenuOpen = ref(false)
const toggleMenu = () => (isMenuOpen.value = !isMenuOpen.value)

const { isHidden } = useScrollHide()
const isCompact = ref(false)

const handleScroll = () => {
  isCompact.value = window.scrollY > 40
}

onMounted(() => window.addEventListener('scroll', handleScroll))
onUnmounted(() => window.removeEventListener('scroll', handleScroll))

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
