<template>
    <authenticated-layout>
    <template #header>
      <h2 class="font-semibold text-xl text-gray-800 leading-tight">
        Services
      </h2>
  <form  class="space-y-6">
    
    <!-- Section: Services -->
    <div v-for="(item, index) in services" :key="index" class="border rounded-lg mb-4 bg-white shadow-md">
      <!-- Titre cliquable -->
      <div
        class="flex justify-between items-center p-4 bg-gray-100 cursor-pointer"
        @click="toggleService(index)"
      >
        <span class="font-semibold text-lg">{{ item.title || 'Service' }}</span>
        <span class="text-xl">{{ expandedIndex === index ? '−' : '+' }}</span>
      </div>

      <!-- Champs visibles si déplié -->
      <div v-show="expandedIndex === index" class="p-4 space-y-4">
        <input v-model="item.title" type="text" placeholder="Titre" class="input" />
        <textarea v-model="item.description" rows="2" placeholder="Description courte" class="input" />

        <!-- ✅ Description longue en HTML -->
        <div>
          <label class="block font-semibold mb-1">Description longue (HTML)</label>
          <QuillEditor
            v-model:content="item.long_description"
            contentType="html"
            theme="snow"
             toolbar="full"
            class="bg-white rounded shadow h-[150px] resize-y overflow-auto"
          />

          
        </div>

        <!-- Sélecteur d'icône 
        <IconSelector v-model="item.icon" />-->
        <!-- Upload image -->
<div>
  <label class="block font-semibold mb-1">Image du service</label>
  <input
    type="file"
    accept="image/*"
    @change="onImageChange($event, index)"
    class="input"
  />
  <!-- Aperçu si image sélectionnée -->
<div v-if="item.background_image" class="mt-2">
  <img :src="item.background_image" alt="Aperçu du service" class="h-32 object-contain rounded shadow" />
</div>
</div>


        <div >
            <label class="block font-semibold mb-1">Seo title</label>
            <input v-model="item.meta_title" type="text" placeholder="Seo title" class="input" />
          </div>
        <div >
            <label class="block font-semibold mb-1">Seo description</label>
            <input v-model="item.meta_description" type="text" placeholder="Seo description" class="input" />
            </div>
            <div >
            <label class="block font-semibold mb-1">Seo keywords (separated by commas)</label>
            <input v-model="item.meta_keywords" type="text" placeholder="Seo keywords" class="input" />
          </div>

        <button
  class="text-red-600"
  type="button"
  @click="deleteItem(item, index)"
>
  Supprimer ce service
</button>

      </div>
    </div>

    <button type="button" class="btn-secondary" @click="addItem">+ Ajouter un service</button>
<div>
     <button
  type="button"
  class="bg-blue-600 text-white px-4 py-2 rounded hover:bg-blue-700 transition"
  @click="Inertia.post(route('services.batch-update'), { items: services })"
>
  Enregistrer les modifications
</button>


    </div>

</form>
    </template>
    </authenticated-layout>
</template>

<script setup>
import { ref } from 'vue'
import IconSelector from '@/Components/IconSelector.vue'
import AuthenticatedLayout from '@/Layouts/AuthenticatedLayout.vue'
import { Inertia } from '@inertiajs/inertia'

const props = defineProps({
  services: Array,
})

const services = ref([...props.services || []])
const expandedIndex = ref(null)

const toggleService = index => {
  expandedIndex.value = expandedIndex.value === index ? null : index
}

function addItem() {
  services.value.push({
    title: '',
    description: '',
    long_description: '',
    icon: '',
    background_image: '',
    imageFile: null, // Pour stocker le fichier sélectionné
    meta_title: '',
    meta_description: '',
    meta_keywords: ''
  })
}



function deleteItem(item, index) {
  if (!window.confirm("Êtes-vous sûr de vouloir supprimer ce service ?")) {
    return
  }

  if (item.id) {
    Inertia.delete(route('services.destroy', item.id), {
      onSuccess: () => {
        services.value.splice(index, 1)
      }
    })
  } else {
    services.value.splice(index, 1)
  }
}


function onImageChange(event, index) {
  const file = event.target.files[0]
  if (!file) return

  // Stocker le fichier pour l'envoi
  services.value[index].imageFile = file

  // Générer un aperçu
  const reader = new FileReader()
  reader.onload = e => {
    services.value[index].background_image = e.target.result
  }
  reader.readAsDataURL(file)
}

</script>


<style scoped>
.input {
  width: 100%;
  padding: 0.5rem;
  border: 1px solid #ccc;
  border-radius: 0.375rem;
  font-size: 1rem;
}
.btn-secondary {
  background-color: #f3f4f6;
  color: #111827;
  padding: 0.5rem 1rem;
  border-radius: 0.375rem;
}
</style>
