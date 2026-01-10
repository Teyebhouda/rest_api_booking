<script setup>
import { Link, router } from '@inertiajs/vue3'
import DashboardLayout from '@/Layouts/AuthenticatedLayout.vue'

defineProps({
  projects: Array,
})

const destroyProject = (id) => {
  if (confirm("Supprimer ce projet ?")) {
    router.delete(route('projects.destroy', id))
  }
}
</script>

<template>
  <DashboardLayout>
    <div class="p-6 max-w-6xl mx-auto">
      <!-- Header -->
      <div class="flex flex-col sm:flex-row justify-between items-start sm:items-center mb-6 gap-4">
        <h1 class="text-3xl font-bold text-gray-800">Liste des Projets</h1>
        <Link 
          :href="route('projects.create')" 
          class="bg-blue-600 hover:bg-blue-700 text-white px-5 py-2 rounded-lg shadow transition-colors duration-300"
        >
          Nouveau Projet
        </Link>
      </div>

      <!-- Table Desktop -->
      <div class="hidden md:block overflow-x-auto shadow-md rounded-lg">
        <table class="w-full border-collapse">
          <thead class="bg-blue-600 text-white">
            <tr>
              <th class="p-3 text-left">Titre</th>
              <th class="p-3 text-left">Lieu</th>
              <th class="p-3 text-left">Date</th>
              <th class="p-3 text-left">Actions</th>
            </tr>
          </thead>
          <tbody class="bg-white">
            <tr 
              v-for="project in projects" 
              :key="project.id" 
              class="border-b hover:bg-gray-50 transition-colors duration-300"
            >
              <td class="p-3 font-medium text-gray-800">{{ project.title }}</td>
              <td class="p-3 text-gray-600">{{ project.location }}</td>
              <td class="p-3 text-gray-600">{{ project.date }}</td>
              <td class="p-3 flex gap-3">
                <Link 
                  :href="route('projects.show', project.id)" 
                  class="text-blue-600 hover:text-blue-800 font-medium"
                >
                  Voir
                </Link>
                <Link 
                  :href="route('projects.edit', project.id)" 
                  class="text-yellow-600 hover:text-yellow-700 font-medium"
                >
                  Modifier
                </Link>
                <button 
                  @click="destroyProject(project.id)" 
                  class="text-red-600 hover:text-red-800 font-medium"
                >
                  Supprimer
                </button>
              </td>
            </tr>
          </tbody>
        </table>
      </div>

      <!-- Cards Mobile -->
      <div class="md:hidden grid gap-4">
        <div 
          v-for="project in projects" 
          :key="project.id" 
          class="bg-white p-4 rounded-lg shadow hover:shadow-lg transition-shadow duration-300"
        >
          <h3 class="font-bold text-lg text-gray-800">{{ project.title }}</h3>
          <p class="text-gray-600 mt-1"><strong>Lieu :</strong> {{ project.location }}</p>
          <p class="text-gray-600"><strong>Date :</strong> {{ project.date }}</p>
          
          <div class="mt-3 flex gap-4">
            <Link 
              :href="route('projects.show', project.id)" 
              class="text-blue-600 hover:text-blue-800 font-medium"
            >
              Voir
            </Link>
            <Link 
              :href="route('projects.edit', project.id)" 
              class="text-yellow-600 hover:text-yellow-700 font-medium"
            >
              Modifier
            </Link>
            <button 
              @click="destroyProject(project.id)" 
              class="text-red-600 hover:text-red-800 font-medium"
            >
              Supprimer
            </button>
          </div>
        </div>
      </div>
    </div>
  </DashboardLayout>
</template>
