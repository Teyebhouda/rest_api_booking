<template>
  <section
    id="projects-section"
    class="bg-white mt-12 py-10 px-6"
    role="region"
    aria-labelledby="projects-title"
  >
    <!-- Wave transition -->
    <div class="absolute -top-12 w-full overflow-hidden leading-[0]">
      <svg class="relative block w-full h-12 text-gray-200" xmlns="http://www.w3.org/2000/svg" preserveAspectRatio="none" viewBox="0 0 1200 120">
        <path d="M0 0c144.3 62.1 286.9 79.9 432 60 172.7-24 343.7-72 520 4 82.1 38.2 161 60 248 54 56.4-3.9 109.3-21 168-43 48.9-19.6 106.4-44.2 132-69V120H0V0z" fill="currentColor"/>
      </svg>
    </div>

    <div class="max-w-screen-xl mx-auto grid grid-cols-1 md:grid-cols-2 gap-16">
      
      <!-- Bloc gauche sticky -->
      <div
        class="flex flex-col justify-start md:sticky max-h-[calc(100vh-6rem)] overflow-visible h-fit "
        :style="{ top: isCompact ? '4.5rem' : '6rem' }"
      >
        <div class="mb-16 text-left">
          
            <h2 class="text-3xl sm:text-4xl font-extrabold text-gray-900 mb-4 leading-tight"
            tabindex="0"
          >
           {{ content.title }}
          </h2>
          <div class="flex items-center gap-3 mb-4">
             <div class="w-10 h-[3px] bg-secondary/60 rounded-full"></div>
            <span class="text-gray-400 text-sm uppercase tracking-widest">{{ content.subtitle }}</span>
          </div>
          <p class="text-gray-700 text-lg leading-relaxed mb-4" tabindex="0">
{{ content.description }}
          </p>
         
        </div>

        <!-- CTA corrigé -->
        <a
          href="/projects"
          class="inline-flex items-center gap-2 bg-primary text-white font-medium px-6 py-3 rounded-xl shadow-lg hover:bg-primary/90 hover:-translate-y-1 hover:shadow-xl transition-all duration-300 focus:outline-none focus:ring-4 focus:ring-primary/50 transform"
          role="button"
          tabindex="0"
          aria-label="Voir tous les projets"
        >
          <svg class="w-5 h-5" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24">
            <path stroke-linecap="round" stroke-linejoin="round" d="M17 8l4 4m0 0l-4 4m4-4H3" />
          </svg>
          Voir tous les projets
        </a>
      </div>

      <!-- Masonry corrigé -->
    <!-- Bloc droit - Projets premium -->
<div class="columns-1 sm:columns-2 lg:columns-3 gap-6 space-y-6" role="list" aria-label="Liste des projets">
  <article
    v-for="(project, index) in content.items.slice(0, 6)"
    :key="project.id"
    class="group relative rounded-2xl overflow-hidden shadow-lg hover:shadow-2xl transition-all duration-500 ring-1 ring-transparent hover:ring-primary/40 cursor-pointer break-inside-avoid"
    :data-aos="index % 2 === 0 ? 'fade-up' : 'fade-down'"
    role="listitem"
    tabindex="0"
    :aria-label="`Projet: ${project.title}`"
  >
    <a :href="`/projects/${project.slug}`" class="block" :aria-label="`Voir les détails du projet ${project.title}`">
      
      <!-- Image du projet -->
      <img
        v-if="project.images.length"
        :src="`/storage/${project.images[0].path}`"
        :alt="project.title"
        class="w-full h-96 object-cover rounded-2xl transition-transform duration-500 transform group-hover:scale-105 group-hover:rotate-1"
        loading="lazy"
      />
      <div
        v-else
        class="w-full h-96 bg-gray-200 flex items-center justify-center text-gray-500 text-sm italic"
      >
        Aucune image disponible
      </div>

      <!-- Overlay texte -->
      <div
        class="overlay absolute inset-0 flex flex-col justify-end p-6 bg-gradient-to-t from-black/70 to-transparent backdrop-blur-sm translate-y-6 opacity-0 group-hover:translate-y-0 group-hover:opacity-100 transition-all duration-500"
        aria-hidden="true"
      >
        <h3 class="text-white text-xl font-bold drop-shadow-md">{{ project.title }}</h3>
        <p class="text-gray-200 text-sm line-clamp-2 mt-1">{{ project.description }}</p>
        <div class="flex justify-between text-gray-300 text-xs mt-2">
          <span>📍 {{ project.location }}</span>
          <span>📅 {{ formatDate(project.date) }}</span>
        </div>
      </div>

      <!-- Badge catégorie (optionnel) -->
      <span
        v-if="project.category"
        class="absolute top-4 left-4 bg-primary/80 text-white text-xs font-semibold px-2 py-1 rounded-full shadow-md"
      >
        {{ project.category }}
      </span>

    </a>
  </article>
</div>

    </div>
    
  </section>
</template>


<script setup>
import { defineProps, onMounted, watch, nextTick, ref } from "vue"
import AOS from "aos"
import "aos/dist/aos.css"

const props = defineProps({
 
  content: {
    type: Object,
    default: () => ({
      title: "Nos Projets",
      subtitle: "Découvrez nos réalisations",
      description: "Explorez une sélection de nos projets récents, illustrant notre expertise et notre engagement envers l'excellence dans chaque réalisation."
    })
  }
})

function formatDate(date) {
  return new Date(date).toLocaleDateString("fr-FR", {
    year: "numeric",
    month: "long",
    day: "numeric"
  })
}

const isCompact = ref(false)

const handleScroll = () => {
  isCompact.value = window.scrollY > 40
}

onMounted(async () => {
  window.addEventListener('scroll', handleScroll)
  await nextTick()
  AOS.init({ duration: 1000, once: true })
})

watch(
  () => props.content,
  async () => {
    await nextTick()
    AOS.refresh()
  }
)
</script>

<style scoped>
.scroll-mt-28 {
  scroll-margin-top: 6rem; /* hauteur de ton header desktop */
}

@media (max-width: 768px) {
  .scroll-mt-28 {
    scroll-margin-top: 4.5rem; /* header mobile */
  }
}
.transform {
  transform-origin: center;
}

</style>
