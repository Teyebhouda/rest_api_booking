<template>
  <section
    class="relative w-full px-4 sm:px-12 py-24 bg-cover bg-center bg-fixed"
    :style="bgStyle"
  >
    <div class="absolute inset-0 bg-black/55 backdrop-blur-[2px]"></div>

    <div class="relative z-10 max-w-6xl mx-auto text-center">

      <!-- Titre -->
      <h2 ref="titleRef"
          v-if="content.title && content.title !== 'null'"
          class="font-display text-3xl sm:text-3xl md:text-4xl font-bold text-white tracking-tight mb-6 opacity-0">
        {{ content.title }}
      </h2>

      <!-- Description -->
      <p ref="descRef"
         v-if="content.description && content.description !== 'null'"
         class="font-sans text-base sm:text-lg text-white/85 max-w-3xl mx-auto mb-12 leading-relaxed opacity-0">
        {{ content.description }}
      </p>

      <!-- Liste -->
      <ul class="flex flex-wrap justify-center gap-x-16 gap-y-10 text-white/95 w-full">
        <li
          v-for="(item, index) in content.items"
          :key="item.text"
          ref="setItemRef"
          class="flex flex-col items-center gap-4 w-[200px] sm:w-[240px] cursor-pointer transform transition-all duration-300 hover:scale-105 hover:rotate-2 hover:shadow-lg hover:text-secondary"
        >
          <component
            :is="icons[index]"
            class="w-12 h-12 sm:w-14 sm:h-14 text-secondary drop-shadow-md"
          />
          <span class="font-medium text-base sm:text-lg tracking-wide text-center leading-snug">
            {{ item.text }}
          </span>
        </li>
      </ul>

    </div>
  </section>
</template>

<script setup>
import { ref, onMounted, nextTick } from 'vue';
import { gsap } from 'gsap';
import {
  WrenchScrewdriverIcon,
  ShieldCheckIcon,
  ClockIcon,
  BuildingOffice2Icon
} from '@heroicons/vue/24/outline';

const props = defineProps({
  content: {
    type: Object,
    default: () => ({
      title: "Notre engagement d’excellence",
      description: "Nous garantissons la qualité et la sécurité sur tous nos chantiers.",
      image:
        "https://images.unsplash.com/photo-1600585154340-be6161a56a0c?auto=format&fit=crop&w=1600&q=80",
      items: [
        { text: "Expertise maîtrisée" },
        { text: "Qualité durable" },
        { text: "Respect des délais" },
        { text: "Sécurité et conformité" },
      ],
    }),
  },
});

const icons = [
  WrenchScrewdriverIcon,
  BuildingOffice2Icon,
  ClockIcon,
  ShieldCheckIcon,
];

const bgStyle = { backgroundImage: `url(${props.content.image})` };

const titleRef = ref(null);
const descRef = ref(null);
const itemRefs = ref([]);

// Chaque item reçoit sa ref
const setItemRef = el => {
  if (el) itemRefs.value.push(el);
};

onMounted(async () => {
  await nextTick();

  const tl = gsap.timeline({ delay: 0.3 });

  if(titleRef.value) tl.fromTo(titleRef.value, { y:40, opacity:0 }, { y:0, opacity:1, duration:1, ease:'power3.out' });
  if(descRef.value) tl.fromTo(descRef.value, { y:40, opacity:0 }, { y:0, opacity:1, duration:1, ease:'power3.out' }, "-=0.6");

  if(itemRefs.value.length){
    tl.from(itemRefs.value, { y:30, opacity:0, scale:0.9, duration:0.8, ease:'power3.out', stagger:0.2 });
  }
});
</script>

<style scoped>

</style>
