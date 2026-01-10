<script setup>
import { useForm } from '@inertiajs/vue3'
import DashboardLayout from '@/Layouts/AuthenticatedLayout.vue'
import { ref } from 'vue'
import { Inertia } from '@inertiajs/inertia'
import { QuillEditor } from '@vueup/vue-quill'

const props = defineProps({
  project: Object
})

// Formulaire
const form = useForm({
  title: props.project?.title || '',
  description: props.project?.description || '',
  content: props.project?.content || '',
  location: props.project?.location || '',
  date: props.project?.date || '',
  meta_title: props.project?.meta_title || '',
  meta_description: props.project?.meta_description || '',
  meta_keywords: props.project?.meta_keywords || ''
})

// Fichiers + aperçus
const images = ref([]) // nouvelles images
const previews = ref([
  ...(props.project?.images?.map(img => ({ id: img.id, url: '/storage/' + img.path, existing: true })) || [])
])
const removedImages = ref([])

// Ajouter des fichiers
const handleFiles = (e) => {
  const files = Array.from(e.target.files)
  files.forEach(f => {
    images.value.push(f)
    previews.value.push({ id: null, url: URL.createObjectURL(f), existing: false })
  })
}

// Supprimer une image
const removeFile = (index) => {
  const img = previews.value[index]
  if (img.existing) {
    removedImages.value.push(img.id) // garder l’ID pour suppression backend
  } else {
    // si c’est une image ajoutée avant submit
    const newIndex = previews.value.filter(p => !p.existing).indexOf(img)
    images.value.splice(newIndex, 1)
  }
  previews.value.splice(index, 1)
}
const processing = ref(false)
// Soumission
const submit = () => {
    processing.value = true
  const fd = new FormData()
  fd.append('title', form.title)
  fd.append('description', form.description)
  fd.append('content', form.content)
  fd.append('location', form.location)
  fd.append('date', form.date || '')
  fd.append('meta_title', form.meta_title)
  fd.append('meta_description', form.meta_description)
  fd.append('meta_keywords', form.meta_keywords)

  // Images à uploader
  images.value.forEach(file => fd.append('images[]', file))

  // Images supprimées
  removedImages.value.forEach(id => fd.append('removed_images[]', id))

  // Méthode PUT
  fd.append('_method', 'PUT')

  Inertia.post(route('projects.update', props.project.id), fd, {
    forceFormData: true,
    onSuccess: () => console.log('✅ Projet mis à jour'),
    onError: err => console.error('⚠️ Erreur', err),
    onFinish: () => {
      processing.value = false
    }
  })
}
</script>

<template>
  <DashboardLayout>
    <div class="max-w-3xl mx-auto bg-white p-6 rounded-xl shadow">
      <h1 class="text-2xl font-bold mb-4">Modifier le projet</h1>
      <form @submit.prevent="submit" class="space-y-4">
        <input v-model="form.title" type="text" placeholder="Titre"
               class="w-full border rounded p-2 focus:ring focus:ring-blue-300" />
       
        <textarea v-model="form.description" placeholder="Description"
                  class="w-full border rounded p-2 focus:ring focus:ring-blue-300"></textarea>
       <QuillEditor   v-model:content="form.content"   contentType="html" theme="snow" toolbar="full"
            class="bg-white rounded shadow h-[150px] resize-y overflow-auto" />
        <input v-model="form.location" type="text" placeholder="Lieu"
               class="w-full border rounded p-2 focus:ring focus:ring-blue-300" />
        <input v-model="form.date" type="date"
               class="w-full border rounded p-2 focus:ring focus:ring-blue-300" />

        <input type="file" multiple accept=".png,.jpg,.jpeg,.webp,.avif"
               @change="handleFiles" class="w-full border p-2" />

        <!-- Aperçus -->
        <div class="flex gap-2 flex-wrap mt-2">
          <div v-for="(img, i) in previews" :key="i" class="relative w-24 h-24">
            <img :src="img.url" class="w-24 h-24 object-cover rounded border shadow-sm" />
            <button type="button" @click="removeFile(i)"
                    class="absolute top-1 right-1 bg-red-600 text-white rounded-full px-1.5 py-0.5 text-xs hover:bg-red-700">
              ✕
            </button>
          </div>
        </div>
        <!-- SEO Fields -->
        <input v-model="form.meta_title" type="text" placeholder="SEO Title"
               class="w-full border rounded p-2 focus:ring focus:ring-blue-300" />
        <input v-model="form.meta_description" type="text" placeholder="SEO Description"
                class="w-full border rounded p-2 focus:ring focus:ring-blue-300" />
        <input v-model="form.meta_keywords" type="text" placeholder="SEO Keywords (comma separated)"
               class="w-full border rounded p-2 focus:ring focus:ring-blue-300" />
<div class="flex gap-4 mt-6">


        <button type="submit" class="bg-green-600 text-white px-4 py-2 rounded hover:bg-green-700 transition" :disabled="processing">
          {{ processing ? 'Mise à jour...' : ' Mettre à jour' }}
         
        </button>     
        <button type="button" class="bg-gray-500 text-white px-4 py-2 rounded hover:bg-gray-600 transition"
                @click="$inertia.visit(route('projects.index'))">
          Annuler
        </button>
        </div>
      </form>
    </div>
  </DashboardLayout>
</template>
