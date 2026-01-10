<template>
  <div
    class="relative"
    @mouseenter="isOpen = true"
    @mouseleave="isOpen = false"
  >
    <!-- Bouton -->
    <button
      class="flex items-center gap-1 hover:text-primary transition-colors duration-200 focus:outline-none focus:text-primary focus:ring-2 focus:ring-primary rounded"
      aria-haspopup="true"
      :aria-expanded="isOpen.toString()"
    >
      {{ title }}
      <svg
        class="w-4 h-4 transition-transform transform"
        :class="{ 'rotate-180': isOpen }"
        fill="none"
        stroke="currentColor"
        viewBox="0 0 24 24"
        aria-hidden="true"
      >
        <path
          d="M19 9l-7 7-7-7"
          stroke-width="2"
          stroke-linecap="round"
          stroke-linejoin="round"
        />
      </svg>
    </button>

    <!-- Dropdown -->
    <transition name="fade">
      <div
        v-show="isOpen"
        class="absolute left-0 mt-2 w-56 bg-white shadow-lg rounded-md transition-opacity duration-200 z-50"
      >
        <a
          v-for="(item, index) in items"
          :key="index"
          :href="`/projects/${item.slug}`"
          class="block px-4 py-2 hover:bg-primary/10 text-gray-700 transition-colors duration-150 focus:outline-none focus:bg-primary/20 rounded"
          tabindex="0"
        >
          {{ item.title }}
        </a>
      </div>
    </transition>
  </div>
</template>

<script setup>
import { ref } from 'vue'

const props = defineProps({
  items: Array,
  title: String,
  slugify: Function // Optional if you want slugs
})

const isOpen = ref(false)
</script>

<style>
.fade-enter-active,
.fade-leave-active {
  transition: opacity 0.2s ease;
}
.fade-enter-from,
.fade-leave-to {
  opacity: 0;
}
</style>
