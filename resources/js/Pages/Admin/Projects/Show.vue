<script setup>
import { defineProps } from 'vue'
import DashboardLayout from '@/Layouts/AuthenticatedLayout.vue'
defineProps({
  project: Object
})
</script>

<template>
    <DashboardLayout>
  <div class="max-w-3xl mx-auto bg-white p-6 rounded-xl shadow">
    <h1 class="text-2xl font-bold mb-2">{{ project.title }}</h1>
    <p class="text-gray-600 mb-2">{{ project.location }} - {{ project.date }}</p>
    <p class="mb-4">{{ project.description }}</p>

    <div class="grid grid-cols-2 md:grid-cols-3 gap-2">
      <img v-for="img in project.images" :key="img.id" :src="`/storage/${img.path}`" class="rounded-lg shadow" />
    </div>
  </div>
    </DashboardLayout>
</template>
