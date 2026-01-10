<template>
  <section
    class="relative bg-fixed bg-center bg-cover py-24 px-6 sm:px-12"
    :style="{ backgroundImage: `url('${content.background_image || defaultBackground}')` }"
    role="region"
    aria-label="Section avec image de fond et statistiques"
  >
    <!-- Overlay sombre pour contraste -->
    <div class="absolute inset-0 bg-gradient-to-r from-black/80 to-black/50" aria-hidden="true"></div>

    <!-- Contenu -->
    <div class="relative z-10 max-w-6xl mx-auto grid md:grid-cols-2 gap-12 items-center">
      <!-- Texte -->
      <div class="text-white space-y-6">
        <h2 class="text-3xl sm:text-4xl font-extrabold leading-tight" tabindex="0">
          {{ content.title || "Titre par défaut" }}
        </h2>
        <p class="text-base sm:text-lg text-gray-100 leading-relaxed" tabindex="0">
          {{ content.description || "Description par défaut..." }}
        </p>

        <!-- Statistiques animées -->
        <div class="grid grid-cols-2 gap-6 mt-8" role="list" aria-label="Statistiques clés">
          <div
            v-for="(stat, index) in content.stats || []"
            :key="index"
            class="stat-card bg-white/20 backdrop-blur-md p-6 rounded-xl text-center shadow-lg transition-transform hover:scale-105 cursor-default"
            role="listitem"
            tabindex="0"
          >
            <h3 class="text-3xl font-bold text-secondary"> <span ref="statRefs">{{ stat.value }}</span></h3>
            <p class="text-sm text-gray-100"> {{ stat.label }} </p>
          </div>
        </div>
      </div>

      <!-- Image décorative -->
      <div
        v-if="content.image"
        class="image-decor hidden md:block relative rounded-2xl shadow-2xl border-4 border-secondary overflow-hidden"
        role="img"
        :aria-label="content.image_alt || 'Image décorative'"
      >
        <img
          :src="content.image"
          :alt="content.image_alt || 'Image décorative'"
          class="rounded-2xl object-cover w-full h-full transition-transform duration-500 hover:scale-105"
          loading="lazy"
        />
        <div
          v-if="content.badge"
          class="absolute -bottom-6 -left-6 bg-secondary text-white font-semibold text-sm px-5 py-2 rounded-lg shadow-xl select-none"
        >
          {{ content.badge }}
        </div>
      </div>
    </div>

    <!-- Petite marge pour transition fluide -->
    <div class="mt-12"></div>
  </section>
</template>

<script setup>
import { ref, onMounted, nextTick } from 'vue'

const props = defineProps({
  content: {
    type: Object,
    default: () => ({
      title: "",
      description: "",
      stats: [],
      background_image: "",
      image: "",
      badge: "",
      image_alt: ""
    })
  }
})

const defaultBackground =
  "https://images.unsplash.com/photo-1600585154340-be6161a56a0c?auto=format&fit=crop&w=1600&q=80"

// Références pour chaque chiffre
const statRefs = ref([])

// Fonction pour animer les chiffres
const animateNumber = (el, target) => {
  let current = 0
  const increment = target / 100
  const interval = setInterval(() => {
    current += increment
    if (current >= target) {
      el.innerText = target
      clearInterval(interval)
    } else {
      el.innerText = Math.floor(current)
    }
  }, 15)
}

onMounted(() => {
  nextTick(() => {
    if ('IntersectionObserver' in window) {
      const observer = new IntersectionObserver((entries, obs) => {
        entries.forEach(entry => {
          if (entry.isIntersecting) {
            statRefs.value.forEach((el, idx) => {
              const target = parseInt(props.content.stats[idx].value, 10)
              animateNumber(el, target)
            })
            obs.disconnect()
          }
        })
      }, { threshold: 0.5 })
      statRefs.value.forEach(el => observer.observe(el))
    } else {
      // fallback: animation immédiate
      statRefs.value.forEach((el, idx) => {
        el.innerText = props.content.stats[idx].value
      })
    }
  })
})
</script>


<style scoped>
/* Animation des stats */
@keyframes fadeUp {
  0% { opacity: 0; transform: translateY(20px); }
  100% { opacity: 1; transform: translateY(0); }
}
.stat-card {
  opacity: 0;
  animation: fadeUp 0.8s ease forwards;
}
.stat-card:nth-child(1) { animation-delay: 0.1s; }
.stat-card:nth-child(2) { animation-delay: 0.3s; }
.stat-card:nth-child(3) { animation-delay: 0.5s; }
.stat-card:nth-child(4) { animation-delay: 0.7s; }

/* Hover subtil sur l'image décorative */
.image-decor img {
  transition: transform 0.5s ease;
}
.image-decor:hover img {
  transform: scale(1.05);
}

/* Parallax background */
section[role="region"] {
  background-attachment: fixed;
  background-position: center;
  background-size: cover;
}
</style>
