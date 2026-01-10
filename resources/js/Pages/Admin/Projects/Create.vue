<script setup>
import { useForm } from '@inertiajs/vue3'
import { ref } from 'vue'
import DashboardLayout from '@/Layouts/AuthenticatedLayout.vue'

const form = useForm({
  title: '',
  description: '',
  location: '',
  date: '',
  images: [],
  content: '',
   meta_title: '',
    meta_description: '',
    meta_keywords: ''
})

const previews = ref([])
const processing = ref(false)
const submit = () => {
   processing.value = true
  const formData = new FormData()
  formData.append("title", form.title)
  formData.append("description", form.description)
  formData.append("location", form.location)
  formData.append("date", form.date)
  formData.append("content", form.content)

  form.images.forEach((file, i) => {
    formData.append(`images[${i}]`, file)
  })

  form.post(route('projects.store'), {
    data: formData,
    forceFormData: true,
     onFinish: () => {
      processing.value = false
    }
  })
}

const handleFiles = (e) => {
  const files = Array.from(e.target.files)
  form.images.push(...files)
  previews.value.push(...files.map(f => URL.createObjectURL(f)))
}

const removeFile = (index) => {
  form.images.splice(index, 1)
  previews.value.splice(index, 1)
}
</script>

<template>
    <DashboardLayout>
      <br />
  <div class="max-w-3xl mx-auto bg-white p-6 rounded-xl shadow ">
    <h1 class="text-2xl font-bold mb-4">Ajouter un projet</h1>

    <form @submit.prevent="submit" class="space-y-4">
      <input v-model="form.title" type="text" placeholder="Titre" class="w-full border rounded p-2" />
      <textarea v-model="form.description" placeholder="Description" class="w-full border rounded p-2"></textarea>
     
      <QuillEditor
                v-model:content="form.content"
                contentType="html"
                theme="snow"
                toolbar="full"
                placeholder=" Long-description"
                class="bg-white rounded shadow h-[300px] resize-y overflow-auto"
              />
      <input v-model="form.location" type="text" placeholder="Lieu" class="w-full border rounded p-2" />
      <input v-model="form.date" type="date" class="w-full border rounded p-2" />

      <!-- Upload -->
      <input type="file" multiple @change="handleFiles" class="w-full border p-2" />

      <!-- Previews -->
      <div class="flex gap-2 flex-wrap mt-3">
        <div 
          v-for="(img, i) in previews" 
          :key="i" 
          class="relative w-24 h-24"
        >
          <img :src="img" class="w-24 h-24 object-cover rounded border" />

          <!-- Delete button -->
          <button
            type="button"
            @click="removeFile(i)"
            class="absolute top-1 right-1 bg-red-600 text-white rounded-full px-1.5 py-0.5 text-xs hover:bg-red-700"
          >
            ✕
          </button>
        </div>
      </div>
      <!-- SEO Fields -->
      <input v-model="form.meta_title" type="text" placeholder="SEO Title" class="w-full border rounded p-2" />
      <input v-model="form.meta_description" type="text" placeholder="SEO Description" class="w-full border rounded p-2" />
      <input v-model="form.meta_keywords" type="text" placeholder="SEO Keywords (comma separated)" class="w-full border rounded p-2" />
<div class="flex gap-4 mt-6">
      <button type="submit" class="bg-blue-600 text-white px-4 py-2 rounded hover:bg-blue-700" :disabled="processing">
        {{ processing ? 'Enregistrement...' : 'Enregistrer' }}
      </button>
      <button
        type="button"
        class="bg-gray-500 text-white px-4 py-2 rounded hover:bg-gray-600"
        
        @click="$inertia.visit(route('projects.index'))"
      > Annuler</button> 
      </div>
    </form>
  </div>
    </DashboardLayout>
</template>
