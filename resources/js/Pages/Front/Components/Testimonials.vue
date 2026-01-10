<template>
  <section class="bg-white py-20 px-4 md:px-20">
    <div class="max-w-7xl mx-auto text-center">
      <!-- Titre animé -->
      <h2
        class="text-3xl md:text-4xl font-bold text-[#1B2B50] mb-12 opacity-0 transform translate-y-6 transition-all duration-700"
        :class="{ 'opacity-100 translate-y-0': isVisible }"
        v-intersect="onIntersect"
      >
        {{ content.title }}
      </h2>

      <!-- Swiper avec animation des slides -->
      <Swiper
        :modules="[Autoplay, Pagination, Scrollbar]"
        :slides-per-view="1"
        :space-between="24"
        :breakpoints="{
          768: { slidesPerView: 2 },
          1024: { slidesPerView: 3 }
        }"
        :loop="true"
        :autoplay="{ delay: 3500, disableOnInteraction: false }"
        :pagination="{ clickable: true }"
        :scrollbar="{ draggable: true }"
        class="pb-10 opacity-0 transform translate-y-6 transition-all duration-700 delay-300"
        :class="{ 'opacity-100 translate-y-0': isVisible }"
      >
        <SwiperSlide
          v-for="(testimonial, index) in content.items"
          :key="testimonial.name"
          class="testimonial-slide"
          :style="{ animationDelay: `${index * 150}ms` }"
        >
          <div class="bg-[#F8F9FB] p-6 rounded-xl shadow hover:shadow-xl transition duration-300">
            <p class="text-gray-700 mb-4">“{{ testimonial.message }}”</p>
            <div class="flex items-center space-x-4 justify-center">
              <img
                :src="testimonial.background_image"
                class="w-12 h-12 rounded-full object-cover"
                :alt="testimonial.name"
              />
              <div>
                <p class="font-semibold text-[#1B2B50]">{{ testimonial.name }}</p>
                <p class="text-sm text-gray-500">{{ testimonial.role }}</p>
              </div>
            </div>
          </div>
        </SwiperSlide>
        <div class="swiper-pagination"></div>
      </Swiper>
    </div>
  </section>
</template>

<script setup>
import { ref } from 'vue'
import { Swiper, SwiperSlide } from 'swiper/vue'
import { Autoplay, Pagination, Scrollbar } from 'swiper/modules'
import 'swiper/css'
import 'swiper/css/pagination'
import 'swiper/css/scrollbar'

const isVisible = ref(false)
function onIntersect(intersecting) {
  if (intersecting) isVisible.value = true
}

defineProps({
  content: {
    type: Object,
    default: () => ({ items: [] })
  }
})
</script>

<script>
export default {
  directives: {
    intersect: {
      mounted(el, binding) {
        const observer = new IntersectionObserver(
          ([entry]) => {
            if (entry.isIntersecting) {
              binding.value(true)
              observer.unobserve(el)
            }
          },
          { threshold: 0.3 }
        )
        observer.observe(el)
      }
    }
  }
}
</script>

<style scoped> 
/* Animation pour chaque slide testimonial */
.testimonial-slide {
  opacity: 0;
  transform: translateY(40px);
  animation-fill-mode: forwards;
  animation-name: slideFadeIn;
  animation-duration: 0.7s;
  animation-timing-function: cubic-bezier(.68, -0.55, .27, 1.55);
}

@keyframes slideFadeIn {
  to {
    opacity: 1;
    transform: translateY(0);
  }
}

/* Personnalisation de la scrollbar Swiper */
::v-deep  .swiper-scrollbar {
  background-color: #f0f0f0 !important;
  border-radius: 5px;
  height: 4px;
}

::v-deep  .swiper-scrollbar-drag {
  background-color: #f8a91d9c !important;
  border-radius: 5px;
}


::v-deep .swiper-pagination-bullet {
  background-color: rgba(28, 56, 78, 0.5);
  width: 8px;
  height: 8px;
  opacity: 0.7;
  transition: background-color 0.3s ease;
}

::v-deep .swiper-pagination-bullet-active {
  background-color: rgb(28, 56, 78);
  width: 10px;
  height: 10px;
  box-shadow: 0 0 8px rgb(28, 56, 78);
}



</style>
