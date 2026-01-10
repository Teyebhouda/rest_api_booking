<template>
  <section class="relative w-full h-[70vh] md:h-[100vh] pt-20 overflow-hidden">

    <!-- BACKGROUND DECORS -->
    <div class="absolute inset-0 pointer-events-none z-0">
      <div class="absolute -top-40 -right-32 w-[420px] h-[420px] bg-primary/10 rounded-full blur-[120px]"></div>
      <div class="absolute -bottom-40 -left-20 w-[300px] h-[300px] bg-secondary/10 rounded-full blur-[100px]"></div>
    </div>

    <!-- SWIPER -->
    <Swiper
      :modules="[Autoplay, Pagination, EffectFade]"
      :slides-per-view="1"
      :loop="true"
      :autoplay="{ delay: 5000, disableOnInteraction: false }"
      :pagination="{ clickable: true, el: '.custom-pagination' }"
       effect="fade"
      :fadeEffect="{ crossFade: true }"
      speed="1000"
      class="w-full h-full relative z-10"
    >
      <SwiperSlide
        v-for="(slide, i) in slides"
        :key="i"
        class="relative w-full h-full"
      >
        <!-- Image -->
        <div
          class="absolute inset-0 bg-cover bg-center scale-105 opacity-90 transition-transform duration-[3000ms]"
          :style="{ backgroundImage: `url('${slide.background_image}')` }">
        </div>

        <!-- Overlay -->
        <div class="absolute inset-0 bg-gradient-to-r from-black/60 to-black/30"></div>

        <!-- Content -->
        <div class="relative z-20 h-full flex items-center px-6 md:px-20">
          <div class="max-w-2xl animate-fadeUp" :class="isMobile ? 'text-center mx-auto' : 'text-left'">

            <!-- Company Typing -->
            <h2 class="text-3xl md:text-5xl font-extrabold text-white mb-3">
              {{ displayedText }}
            </h2>

            <!-- Title -->
            <h1 class="text-xl md:text-4xl font-bold text-secondary-light mb-3">
              {{ slide.title }}
            </h1>

            <!-- Subtitle -->
            <p class="text-gray-200 text-sm md:text-lg leading-relaxed mb-5">
              {{ slide.subtitle }}
            </p>

            <!-- Button -->
            <a
              v-if="slide.button_text"
              href="#contact-form"
              class="inline-block px-6 py-3 bg-secondary text-white rounded-modern
                     hover:bg-secondary-dark shadow-soft hover:shadow-softLg transition">
              {{ slide.button_text }}
            </a>

          </div>
        </div>
      </SwiperSlide>

      <!-- Pagination -->
      <div class="custom-pagination absolute bottom-8 left-1/2 -translate-x-1/2 z-30"></div>
    </Swiper>

    <!-- Services Cards (below Hero) -->
  <!-- Services Cards (below Hero) -->
<!-- Services Cards -->
<div class="relative z-[50] -mt-12 md:-mt-20 px-4 md:px-12 animate-fadeUp">
  <div class="relative z-[60] bg-white/90 backdrop-blur-lg rounded-modern shadow-soft p-4 md:p-8">

    <!-- Mobile Swiper -->
    <div class="block md:hidden">
      <Swiper
        :modules="[Pagination]"
        :slides-per-view="2.3"
        :space-between="12"
        :pagination="{ clickable: true }"
        class="!pb-6 relative z-10"
      >
        <SwiperSlide v-for="(service, i) in services" :key="i">
          <div
            class="p-4 bg-white rounded-modern shadow-soft hover:shadow-softLg
                   transition flex flex-col items-center cursor-pointer"
            @click="scrollToService(service.id)"
          >
            <component :is="icons[i % icons.length]" class="h-6 w-6 text-primary mb-2 animate-iconGlow" />
            <h3 class="text-gray-800 text-sm font-semibold text-center leading-snug animate-fadeInUpCard">
              {{ service.title }}
            </h3>
          </div>
        </SwiperSlide>
      </Swiper>
    </div>

    <!-- Desktop Grid -->
    <div class="hidden md:grid grid-cols-2 lg:grid-cols-4 gap-5">
      <div
        v-for="(service, i) in services"
        :key="i"
        class="p-5 bg-white rounded-modern shadow-soft hover:shadow-softLg
               transition text-center cursor-pointer flex flex-col items-center justify-center relative z-10"
        @click="scrollToService(service.id)"
      >
        <component :is="icons[i % icons.length]" class="h-8 w-8 text-primary mb-3 animate-iconGlow" />
        <h3 class="text-gray-800 text-sm md:text-base font-semibold leading-snug animate-fadeInUpCard">
          {{ service.title }}
        </h3>
      </div>
    </div>

  </div>
</div>
</section>
</template>


<script setup>
import { ref, onMounted } from 'vue'
import { Swiper, SwiperSlide } from 'swiper/vue'
import { Autoplay, Pagination, EffectFade } from 'swiper/modules'
import 'swiper/css'
import 'swiper/css/pagination'
import 'swiper/css/effect-fade'

import {
  WrenchIcon,
  BuildingOffice2Icon,
  SparklesIcon,
  ShieldCheckIcon,
  LightBulbIcon,
  ClipboardDocumentListIcon,
} from '@heroicons/vue/24/outline'

const icons = [
  WrenchIcon,
  BuildingOffice2Icon,
  SparklesIcon,
  ShieldCheckIcon,
  LightBulbIcon,
  ClipboardDocumentListIcon,
]

const props = defineProps({
  content: { type: Object, default: () => ({ slides: [] }) },
  services: { type: Array, default: () => [] },
})

const slides = props.content.slides || []
const services = props.services || []

const emit = defineEmits(['selectService'])
const scrollToService = (serviceId) => {
  emit('selectService', serviceId)
  const section = document.getElementById('services-section')
  if (section) section.scrollIntoView({ behavior: 'smooth' })
}

// Typing effect
const companyName = 'FSD BÂTIMENT'
const displayedText = ref('')
let i = 0
const typeWriter = () => {
  if (i < companyName.length) {
    displayedText.value += companyName.charAt(i)
    i++
    setTimeout(typeWriter, 100)
  }
}

// Mobile detection
const isMobile = ref(false)

onMounted(() => {
  typeWriter()
  isMobile.value = window.innerWidth < 768
  window.addEventListener('resize', () => {
    isMobile.value = window.innerWidth < 768
  })
})
</script>
