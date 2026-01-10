<template>
  <div class="w-full">
    <!-- Toggle Button -->
    <button
      @click="toggle"
      class="flex justify-between items-center w-full text-lg font-medium text-gray-800 hover:text-primary focus:outline-none focus:text-primary focus:ring-2 focus:ring-primary rounded"
      aria-haspopup="true"
      :aria-expanded="open.toString()"
    >
      <span>{{ title }}</span>
      <svg
        :class="['w-5 h-5 transform transition-transform duration-200', { 'rotate-180': open }]"
        fill="none"
        stroke="currentColor"
        viewBox="0 0 24 24"
        aria-hidden="true"
      >
        <path d="M19 9l-7 7-7-7" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" />
      </svg>
    </button>

    <!-- Dropdown items -->
    <transition name="fade">
      <div
        v-if="open"
        class="ml-2 mt-2 flex flex-col gap-2 pl-2 border-l border-gray-200"
        role="menu"
      >
        <a
          v-for="(item, i) in items"
          :key="i"
          :href="`/projects/${item.slug}`"
          class="text-base text-gray-700 hover:text-primary font-medium transition-colors duration-150 focus:outline-none focus:text-primary"
          role="menuitem"
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
  items: {
    type: Array,
    default: () => []
  },
  title: String,
  slugify: {
    type: Function,
    default: (text) =>
      text
        .toString()
        .toLowerCase()
        .normalize("NFD").replace(/[\u0300-\u036f]/g, "") // Remove accents
        .replace(/\s+/g, '-')
        .replace(/[^\w-]+/g, '')
        .replace(/--+/g, '-')
        .replace(/^-+|-+$/g, '')
  }
})

const open = ref(false)
const toggle = () => {
  open.value = !open.value
}
</script>

<style>
.fade-enter-active, .fade-leave-active {
  transition: opacity 0.2s ease, transform 0.2s ease;
}
.fade-enter-from, .fade-leave-to {
  opacity: 0;
  transform: translateY(-5px);
}
.fade-enter-to, .fade-leave-from {
  opacity: 1;
  transform: translateY(0);
}
</style>