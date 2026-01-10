<template>
  <section
    ref="servicesSection"
    id="services-section"
    class="relative py-10 transition-all duration-700 ease-out overflow-hidden bg-gradient-to-b from-gray-50 via-white to-gray-100"
    :class="{ 'opacity-100 translate-y-0': isVisible, 'opacity-0 translate-y-10': !isVisible }"
  >

    <!-- Décor très subtil -->
    <div class="absolute inset-0 pointer-events-none opacity-60">
      <div class="absolute -top-24 -right-20 w-[360px] h-[360px] bg-primary/5 rounded-full blur-[90px]"></div>
      <div class="absolute -bottom-28 -left-24 w-[300px] h-[300px] bg-blue-200/10 rounded-full blur-[70px]"></div>
    </div>

    <div class="relative max-w-screen-xl mx-auto px-4 sm:px-6 lg:px-8">

      <!-- Titre -->
      <div class="mb-12 text-left">
        <h2 class="text-3xl sm:text-4xl font-extrabold text-gray-900 mb-3 leading-tight">
          {{ content.title }}
        </h2>
        <div class="flex items-center gap-2 mb-4">
          <div class="w-10 h-[3px] bg-secondary/60 rounded-full"></div>
          <span class="text-gray-500 text-xs uppercase tracking-wider">
            {{ content.subtitle }}
          </span>
        </div>
        <p class="text-lg text-gray-700 max-w-2xl leading-relaxed">
          {{ content.description }}
        </p>
      </div>

      <!-- Tabs -->
      <div class="-mx-4 px-4 overflow-x-auto no-scrollbar">
        <div
          class="flex gap-4 pb-2 border-b border-gray-200 whitespace-nowrap"
          role="tablist"
        >
          <button
            v-for="(service, index) in content.items"
            :key="service.title"
            role="tab"
            :aria-selected="activeTab === index"
            @click="activeTab = index"
            class="px-5 py-2.5 text-sm font-medium rounded-lg transition 
                   focus:outline-none focus:ring-2 focus:ring-primary/70"
            :class="[
              activeTab === index
                ? 'bg-primary text-white shadow'
                : 'bg-white text-gray-600 hover:bg-gray-100 border border-gray-200'
            ]"
          >
            {{ service.title }}
          </button>
        </div>
      </div>

      <!-- Contenu -->
      <transition name="fade" mode="out-in">
        <div
          :key="activeTab"
          class="mt-12 grid grid-cols-1 md:grid-cols-2 gap-10 
                 bg-white rounded-2xl shadow-lg ring-1 ring-gray-200 
                 p-6 sm:p-10 transition-all duration-500"
        >

          <!-- Image -->
          <div class="w-full h-full min-h-[280px] overflow-hidden rounded-xl relative group">
            <img
              :src="content.items[activeTab].background_image || '/images/worker-silhouette.png'"
              class="w-full h-full object-cover rounded-xl transition duration-700 group-hover:scale-105"
            />
            <div class="absolute inset-0 bg-gradient-to-t from-black/40 via-black/5 to-transparent opacity-0 group-hover:opacity-100 transition duration-500"></div>
          </div>

          <!-- Texte -->
          <div class="flex flex-col justify-center">
            <h3 class="text-2xl sm:text-3xl font-semibold text-gray-900 mb-2">
              {{ content.items[activeTab].title }}
            </h3>
            <p class="text-primary text-lg font-medium mb-4">
              {{ content.items[activeTab].subtitle }}
            </p>

            <div
              class="prose prose-sm sm:prose-lg max-w-none text-gray-700 leading-relaxed"
              v-html="content.items[activeTab].description"
            />

            <div
  class="mt-4 text-gray-600 text-sm sm:text-base leading-relaxed line-clamp-5"
  v-html="content.items[activeTab].long_description"
></div>

            
            <div class="mt-6">
         

              <a
                href="#contact-form"
                class="px-6 py-3 bg-primary text-white font-semibold rounded-lg
                       hover:bg-primary/90 hover:shadow-md hover:-translate-y-[2px]
                       transition transform duration-300 inline-block"
              >
                Demander un devis
              </a>
              <a
                :href="`/services/${toSlug(content.items[activeTab].title)}`"
                class="ml-4 px-6 py-3 bg-gray-100 text-gray-800 font-semibold rounded-lg
                       hover:bg-gray-200 hover:shadow-md hover:-translate-y-[2px]
                       transition transform duration-300 inline-block"
              >
                En savoir plus
              </a>
            </div>
          </div>

        </div>
      </transition>

    </div>

    <!-- Courbe bas 
    <div class="absolute bottom-0 left-0 w-full overflow-hidden leading-[0]">
      <svg class="block w-full h-20" xmlns="http://www.w3.org/2000/svg" preserveAspectRatio="none" viewBox="0 0 1200 120">
        <path d="M0,90 L1200,0 L1200,120 L0,120 Z" class="fill-white"></path>
      </svg>
    </div>  -->

  </section>
</template>


<script setup>
import { ref, watch, onMounted } from 'vue'

const servicesSection = ref(null)
const isVisible = ref(false)

onMounted(() => {
  if ('IntersectionObserver' in window) {
    const observer = new IntersectionObserver((entries) => {
      entries.forEach(entry => {
        if (entry.isIntersecting) {
          isVisible.value = true
          observer.disconnect()
        }
      })
    }, { threshold: 0.2 })
    if (servicesSection.value) observer.observe(servicesSection.value)
  } else {
    isVisible.value = true
  }
})

const props = defineProps({
  content: {
    type: Object,
    default: () => ({
      title: "Nos services",
      subtitle: "Des prestations adaptées à vos besoins dans le bâtiment et la construction.",
      items: []
    })
  },
  initialService: [String, Number]
})

const activeTab = ref(0)

watch(
  () => props.initialService,
  (serviceId) => {
    if (serviceId) {
      const idx = props.content.items.findIndex(item => item.id === serviceId)
      if (idx !== -1) activeTab.value = idx
    }
  },
  { immediate: true }
)

const prevTab = () => {
  activeTab.value = (activeTab.value - 1 + props.content.items.length) % props.content.items.length
}

const nextTab = () => {
  activeTab.value = (activeTab.value + 1) % props.content.items.length
}
function toSlug(str) {
  return str
    .toLowerCase()
    .normalize("NFD")
    .replace(/[\u0300-\u036f]/g, "")
    .replace(/[^\w\s-]/g, '')
    .trim()
    .replace(/[\s_-]+/g, '-')
    .replace(/^-+|-+$/g, '');
}
</script>

<style scoped>
.fade-enter-active, .fade-leave-active {
  transition: all 0.5s cubic-bezier(0.22, 1, 0.36, 1);
}
.fade-enter-from {
  opacity: 0;
  transform: scale(0.98) translateY(10px);
}
.fade-leave-to {
  opacity: 0;
  transform: scale(0.98) translateY(-10px);
}

@keyframes fadeInRight {
  0% { opacity: 0; transform: translateX(30px); }
  100% { opacity: 1; transform: translateX(0); }
}
.animate-fadeInRight {
  animation: fadeInRight 0.8s ease-out forwards;
}

/* Animation lente pour les éléments décoratifs */
@keyframes bounce-slow {
  0%, 100% { transform: translateY(0px); }
  50% { transform: translateY(-15px); }
}
.animate-bounce-slow {
  animation: bounce-slow 6s infinite ease-in-out;
}

.line-clamp-5 {
  display: -webkit-box;
  -webkit-line-clamp: 8;
  -webkit-box-orient: vertical;
  overflow: hidden;
}

</style>