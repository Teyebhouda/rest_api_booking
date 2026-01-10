<template>
  <section class="hero relative w-full h-[80vh] md:h-[100vh] overflow-visible">

    <!-- SLIDER BACKGROUND -->
    <Swiper
      :modules="[Autoplay, Pagination, EffectFade]"
      :slides-per-view="1"
      :loop="true"
      :autoplay="{ delay: 6000, disableOnInteraction: false }"
      :pagination="{ clickable: true, el: '.custom-pagination' }"
      effect="fade"
      :fadeEffect="{ crossFade: true }"
      speed="1500"
      class="w-full h-full"
    >
      <SwiperSlide
        v-for="(slide, i) in slides"
        :key="i"
        class="relative w-full h-full"
      >

        <!-- Background + overlay -->
        <img
          :src="slide.background_image"
          loading="lazy"
          alt=""
          class="absolute inset-0 w-full h-full object-cover slider-zoom"
        />
        <div class="absolute inset-0 bg-black/40"></div>

        <!-- CONTENT PANEL -->
        <div class="relative z-20 h-full flex items-center justify-start px-6 md:px-24">
          <div 
            class="hero-panel max-w-3xl animate-panel mt-16 md:mt-24
                   flex flex-col sm:flex-row items-center sm:items-start sm:space-x-6
                   overflow-auto max-h-[70vh] sm:max-h-none"
          >

            <div class="panel-content text-center sm:text-left">
              <!-- Nom entreprise -->
              <h2
                class="font-display text-3xl md:text-5xl font-extrabold mb-4 tracking-wide text-white leading-tight"
              >
                {{ displayedText }}
              </h2>

              <!-- Titre slide -->
              <h1
                class="font-display text-2xl md:text-4xl font-semibold mb-4 text-white/90"
              >
                {{ slide.title }}
              </h1>

              <!-- Sous-titre -->
              <p
                class="font-sans text-base md:text-lg mb-6 leading-relaxed text-white/70"
              >
                {{ slide.subtitle }}
              </p>

              <!-- CTA -->
              <a
                v-if="slide.button_text"
                href="#contact-form"
                class="cta-button inline-block"
              >
                {{ slide.button_text }}
              </a>
            </div>

          </div>
        </div>

      </SwiperSlide>

      <div class="custom-pagination absolute bottom-8 left-1/2 -translate-x-1/2 z-30"></div>
    </Swiper>

    <!-- SERVICES SECTION -->
    <div class="relative z-40 -mt-10 md:-mt-16 px-4 md:px-16">
      <div class="services-wrapper bg-white/80 backdrop-blur-sm rounded-xl shadow-md py-4 px-3 md:px-10">

        <!-- Mobile Swiper -->
        <div class="block md:hidden">
          <Swiper
            :modules="[Pagination]"
            :slides-per-view="2.3"
            :space-between="12"
            :pagination="{ clickable: true }"
            class="!pb-6"
            :breakpoints="{320:{slidesPerView:1.4},480:{slidesPerView:2.1},640:{slidesPerView:2.3}}"
          >
            <SwiperSlide v-for="(service, i) in services" :key="i">
              <div
                class="service-card-mobile group p-3 bg-white border border-gray-100 rounded-xl shadow-sm hover:shadow-yellow transition-all duration-300 flex flex-col items-center justify-center text-center cursor-pointer"
                @click="scrollToService(service.id)"
              >
                <component
                  :is="icons[i % icons.length]"
                  class="h-6 w-6 text-primary mb-2 group-hover:scale-110 transform transition duration-300"
                />
                <h3 class="text-sm font-semibold text-primary group-hover:text-secondary">
                  {{ service.title }}
                </h3>
              </div>
            </SwiperSlide>
          </Swiper>
        </div>

        <!-- Desktop Grid -->
        <div class="hidden md:grid grid-cols-2 lg:grid-cols-3 xl:grid-cols-4 2xl:grid-cols-5 gap-4 lg:gap-6">
          <div
            v-for="(service, i) in services" :key="i"
            class="service-card group p-4 bg-white border border-gray-100 rounded-xl shadow-sm hover:shadow-yellow transition-all duration-300 text-center cursor-pointer flex flex-col items-center justify-center"
            @click="scrollToService(service.id)"
          >
            <component
              :is="icons[i % icons.length]"
              class="h-8 w-8 text-primary mb-2 group-hover:scale-110 transition-transform duration-300"
            />
            <h3 class="text-sm font-semibold text-primary group-hover:text-secondary">
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

// Icons
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
  ClipboardDocumentListIcon
]

const props = defineProps({
  content: Object,
  services: Array,
})

const slides = ref(props.content.slides || [])
const services = ref(props.services || [])

// Scroll event
const emit = defineEmits(['selectService'])
const scrollToService = id => {
  emit('selectService', id)
  const dom = document.getElementById('services-section')
  if (dom) dom.scrollIntoView({ behavior: 'smooth' })
}

// Typewriter
const companyName = 'FSD BÂTIMENT'
const displayedText = ref('')
let i = 0
const typeWriter = () => {
  if (i < companyName.length) {
    displayedText.value += companyName[i]
    i++
    setTimeout(typeWriter, 80)
  }
}

// FIX: Ajuste automatiquement le padding du hero selon la hauteur du header
onMounted(() => {
  typeWriter()

  const header = document.getElementById("main-header")
  const hero = document.querySelector(".hero")

  if (header && hero) {
    const h = header.offsetHeight
    hero.style.paddingTop = `${h + 10}px`
  }
})
</script>

<style scoped>
/* Background subtle zoom */
.slider-zoom {
  animation: zoom 28s ease-in-out infinite alternate;
}
@keyframes zoom {
  0% { transform: scale(1); }
  100% { transform: scale(1.08); }
}

/* DEEP GLASS PREMIUM – multi-layer */
.hero-panel { 
  background: rgba(255, 255, 255, 0.14);
  backdrop-filter: blur(42px) saturate(200%);
  -webkit-backdrop-filter: blur(42px) saturate(200%);
  border-radius: 28px;
  border: 1px solid rgba(255, 255, 255, 0.22);
  box-shadow:
    0 0 45px rgba(255, 255, 255, 0.10),
    0 26px 55px rgba(0, 0, 0, 0.45),
    inset 0 0 28px rgba(255,255,255,0.05),
    inset 0 0 16px rgba(0,0,0,0.25);
  position: relative;
  overflow: hidden;
}

.hero-panel::before {
  content: "";
  position: absolute;
  inset: 0;
  border-radius: 28px;
  background: linear-gradient(
    145deg,
    rgba(255,255,255,0.35),
    rgba(255,255,255,0.10) 40%,
    rgba(255,255,255,0.22) 80%
  );
  opacity: 0.55;
  mask:
    linear-gradient(#000 0 0) content-box,
    linear-gradient(#000 0 0);
  -webkit-mask-composite: xor;
  mask-composite: exclude;
  padding: 3px;
}

.hero-panel::after {
  content: "";
  position: absolute;
  inset: 0;
  background: radial-gradient(
    circle at 30% 20%,
    rgba(255,255,255,0.18),
    transparent 60%
  ),
  radial-gradient(
    circle at bottom right,
    rgba(0,0,0,0.22),
    transparent 70%
  );
  opacity: 0.45;
}

.panel-content {
  padding: 3.5rem 3rem;
}

/* CTA BUTTON BASED ON SECONDARY COLORS */
.cta-button {
  background: linear-gradient(135deg, #FFC04D, #F5A623, #C27800);
  padding: 14px 32px;
  border-radius: 14px;
  color: white;
  font-weight: 600;
  box-shadow:
    0 8px 20px rgba(0,0,0,0.45),
    inset 0 0 10px rgba(255,255,255,0.10),
    inset 0 -4px 6px rgba(0,0,0,0.15);
  transition: 0.25s ease;
}

.cta-button:hover {
  transform: translateY(-3px) scale(1.03);
  background: linear-gradient(135deg, #FFC04D, #F5A623);
  box-shadow:
    0 12px 28px rgba(0,0,0,0.55),
    inset 0 0 14px rgba(255,255,255,0.18),
    inset 0 -6px 10px rgba(0,0,0,0.22);
}

/* Bullets */
.custom-pagination .swiper-pagination-bullet {
  width: 13px;
  height: 13px;
  background: rgba(255,255,255,0.5);
  border: 1px solid rgba(255,255,255,0.4);
  transition: .3s;
}

.custom-pagination .swiper-pagination-bullet-active {
  background: #d29b6b;
  border-color: #d29b6b;
  transform: scale(1.4);
}

/* Animation */
@keyframes panelIn {
  0% { opacity:0; transform:translateY(40px) scale(.95); filter:blur(5px); }
  100% { opacity:1; transform:translateY(0) scale(1); filter:blur(0); }
}
.animate-panel {
  animation: panelIn 1s cubic-bezier(.16,.8,.28,1) forwards;
}
@media (max-width: 767px) {
  .hero-panel {
    display: flex !important;
    flex-direction: row !important;
    align-items: center;
    justify-content: space-around;
    padding: 2.5rem 1.5rem !important;
    
    max-width: 100% !important;
    max-height: 100% !important;
  }
  .panel-content {
    padding: 0 !important;
    flex: 1;
  }
   /* TITRE ENTREPRISE */
  .panel-content h2 {
    font-size: 1.50rem !important;     /* AUGMENTÉ */
    line-height: 1.2 !important;
    font-weight: 800 !important;
    letter-spacing: 0.5px;
    margin-bottom: 0.8rem !important;
  }
  .panel-content h1,
  .panel-content p {
    font-size: smaller;
    margin-bottom: 0.5rem;
  }
  .cta-button {
    padding: 10px 20px;
    font-size: 0.85rem;
    margin-top: 0;
  }
}


</style>
