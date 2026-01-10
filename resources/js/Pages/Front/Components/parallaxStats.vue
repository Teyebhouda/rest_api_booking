<template>
  <section id="parallax-stats" class="relative pt-40 pb-10 bg-gradient-to-b from-neutral-light via-white to-neutral-light overflow-hidden">
    <!-- BLOBS décoratifs -->
    <div class="absolute inset-0 pointer-events-none z-0">
      <div class="absolute -top-32 right-0 w-[380px] h-[380px] bg-primary/10 rounded-full blur-[110px]"></div>
      <div class="absolute -bottom-32 left-0 w-[280px] h-[280px] bg-secondary/10 rounded-full blur-[100px]"></div>
    </div>

    <div class="relative max-w-7xl mx-auto px-6 lg:px-12 z-10">
      <div class="grid lg:grid-cols-2 gap-12 items-center">

        <!-- TEXT + STATS -->
        <div ref="textContainer" class="opacity-0 text-left">
          <h2 class="text-3xl md:text-4xl font-extrabold text-primary mb-4">
            {{ content.title || "À propos de nous" }}
          </h2>
          <p class="text-gray-600 text-lg leading-relaxed mb-8">
            {{ content.description || "Description par défaut ici." }}
          </p>

          <!-- STATS -->
          <div class="grid grid-cols-3 gap-6 mt-6">
            <div
              v-for="(stat, index) in content.stats || []"
              :key="index"
              class="stat-card p-5 bg-white shadow rounded-xl text-center transform transition-all duration-300 hover:scale-105"
              :ref="el => setStatRef(el, index)"
            >
              <h3 class="text-3xl font-extrabold  text-secondary"><span ref="statRefs">{{ stat.value }}</span></h3>
            <p class="text-sm text-gray-500">{{ stat.label }}</p>
            </div>
          </div>
        </div>

        <!-- RIGHT IMAGES -->
        <div ref="imageWrapper" class="relative w-full h-[400px] hidden md:block opacity-0">
          <div class="absolute top-0 left-0 w-2/3 h-3/4 rounded-xl overflow-hidden shadow-lg animate-slideInLeft image-parallax">
            <img :src="content.background_image || defaultMainImg" class="w-full h-full object-cover" />
          </div>
          <div class="absolute bottom-0 right-0 w-2/3 h-3/4 rounded-xl overflow-hidden shadow-2xl border-4 border-white animate-slideInRight delay-300 image-parallax">
            <img :src="content.image || defaultMainImg" class="w-full h-full object-cover" />
          </div>
        </div>

      </div>
    </div>
  </section>
</template>

<script setup>
import { ref, onMounted } from "vue";

const props = defineProps({ content: Object });

// refs
const textContainer = ref(null);
const imageWrapper = ref(null);
const statRefs = ref([]);

const defaultMainImg = "https://source.unsplash.com/800x600/?construction";

// pour lier les refs dynamiques
const setStatRef = (el, index) => { if(el) statRefs.value[index] = el; };



// fonction pour observer l'apparition des éléments
const animateOnVisible = (refTarget, className) => {
  if(!refTarget.value) return;
  const obs = new IntersectionObserver((entries, observer)=>{
    entries.forEach(entry=>{
      if(entry.isIntersecting){
        refTarget.value.classList.add(className);
        observer.disconnect();
      }
    });
  }, { threshold: 0.3 });
  obs.observe(refTarget.value);
};

onMounted(() => {
  // observer pour les stats
  statRefs.value.forEach((el, idx) => {
    const observer = new IntersectionObserver((entries, obs) => {
      entries.forEach(entry => {
        if(entry.isIntersecting){
          const target = parseInt(props.content.stats[idx].value, 10);
          animateNumber(idx, target);
          obs.disconnect();
        }
      });
    }, { threshold: 0.4 });
    observer.observe(el);
  });

  // text + images
  animateOnVisible(textContainer, "animate-fadeInLeft");
  animateOnVisible(imageWrapper, "animate-fadeInRight");

  // parallaxe mouse
  if(imageWrapper.value){
    imageWrapper.value.addEventListener("mousemove", (e)=>{
      const rect = imageWrapper.value.getBoundingClientRect();
      const x = ((e.clientX - rect.left)/rect.width - 0.5) * 20;
      const y = ((e.clientY - rect.top)/rect.height - 0.5) * 20;
      imageWrapper.value.querySelectorAll("img").forEach((img, idx)=>{
        const factor = idx === 0 ? 0.4 : 0.7;
        img.style.transform = `translate3d(${x*factor}px, ${y*factor}px, 0)`;
      });
    });
  }
});
</script>

<style scoped>
.stat-value {
  animation: statGlow 1.5s ease-in-out infinite alternate;
}
@keyframes statGlow {
  0% { text-shadow:0 0 4px #F5A623,0 0 12px rgba(245,166,35,0.3); }
  50% { text-shadow:0 0 8px #FFD36B,0 0 20px rgba(245,166,35,0.5); }
  100% { text-shadow:0 0 4px #F5A623,0 0 12px rgba(245,166,35,0.3); }
}

.animate-fadeInLeft { animation: fadeInLeft 0.8s ease forwards; }
.animate-fadeInRight { animation: fadeInRight 0.8s ease forwards; }
@keyframes fadeInLeft { from { opacity:0; transform:translateX(-30px); } to { opacity:1; transform:translateX(0); } }
@keyframes fadeInRight { from { opacity:0; transform:translateX(30px); } to { opacity:1; transform:translateX(0); } }

.stat-card { transition: all 0.3s ease, box-shadow 0.3s ease; }
.stat-card:hover { transform: scale(1.05); box-shadow: 0 12px 24px rgba(245,166,35,0.2),0 0 10px rgba(245,166,35,0.15) inset; }

.image-parallax { transition: transform 0.2s ease-out; will-change: transform; }
.animate-slideInLeft { animation: slideInLeft 1s ease forwards; }
.animate-slideInRight { animation: slideInRight 1s ease forwards; }
@keyframes slideInLeft { from { opacity:0; transform:translateX(-40px); } to { opacity:1; transform:translateX(0); } }
@keyframes slideInRight { from { opacity:0; transform:translateX(40px); } to { opacity:1; transform:translateX(0); } }
</style>
