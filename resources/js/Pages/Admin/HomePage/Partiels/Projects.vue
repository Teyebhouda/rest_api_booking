<template>
  <form class="space-y-6">
    <div>
      <input v-model="form.title" type="text" placeholder="Titre de la section" class="input text-4xl font-extrabold mb-2 w-full text-center" />
      <input v-model="form.subtitle" type="text" placeholder="Sous-titre de la section" class="input text-lg mb-4 w-full text-center" />
      <textarea v-model="form.description" type="text" rows="3"
        class="w-full border rounded p-2 focus:ring focus:ring-blue-300"
        placeholder="Une description courte de votre section..." />
    </div>
    <div class="mb-6">
      <label class="block text-sm font-medium text-gray-700 mb-1">Sélectionner les projets à afficher sur la page d'accueil</label>
      <p class="text-xs text-gray-500">Les projets sélectionnés seront affichés dans l'ordre défini ici.</p>
    </div>
    <div v-if="allProjects.length === 0">
      <p>Aucun projet disponible.</p>
    </div>

    <div v-else class="space-y-2">
      <div v-for="project in allProjects" :key="project.id" class="flex items-center space-x-2">
        <input
          type="checkbox"
          :value="project.id"
          v-model="form.project_ids"
          class="form-checkbox"
        />
        <label>{{ project.title }}</label>
      </div>
    </div>
 </form>
</template>

<script setup>
import { onMounted, ref } from 'vue'
import { router } from '@inertiajs/vue3'

const props = defineProps({
  form: Object,
})


// On initialise la propriété si elle n'existe pas
if (!props.form.project_ids) {
  props.form.project_ids = []
}

// Liste des projets disponibles
const allProjects = ref([])

onMounted(async () => {
  const response = await fetch('/admin/api/projects') 
  const data = await response.json()
  allProjects.value = data.projects
})
</script>
