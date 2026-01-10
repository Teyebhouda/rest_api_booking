<template>
  <form class="space-y-6">
 
    <!-- Image de fond -->
    <div>
      <label class="block font-medium mb-1">Image de fond</label>
      <input type="file" @change="handleImageUpload" class="block w-full border rounded p-2" />
      <div v-if="localform.image" class="mt-2">
        <img :src="localform.image" alt="Aperçu image" class="max-w-sm rounded" />
      </div>
    </div>

    <!-- Titre principal -->
    <div>
      <label class="block font-medium mb-1">Titre</label>
      <input type="text" v-model="localform.title" class="block w-full border rounded p-2" />
    </div>

    <!-- Paragraphe d’intro -->
    <div>
      <label class="block font-medium mb-1">Texte d’introduction</label>
      <textarea v-model="localform.description" rows="4" class="block w-full border rounded p-2"></textarea>
    </div>

    <!-- Liste des raisons -->
    <div>
      <label class="block font-medium mb-1">Raisons</label>
      <div v-for="(item, index) in localform.items" :key="index" class="flex items-center space-x-2 mb-2">
        <input
          v-model="item.text"
          type="text"
          placeholder="Ex: Support post-projet assuré"
          class="w-full border rounded p-2"
        />
        <button type="button" @click="removeItem(index)" class="text-red-500 hover:underline">Supprimer</button>
      </div>
      <button type="button" @click="addItem" class="mt-2 px-3 py-1 bg-green-500 text-white rounded hover:bg-green-600">
        + Ajouter une raison
      </button>
    </div>

</form>
</template>

<script setup>


import { computed } from 'vue'

const props = defineProps({
  form: Object
})
const emit = defineEmits(['update:form'])

// Liaison bidirectionnelle avec le parent
const localform = computed({
  get: () => props.form,
  set: value => emit('update:form', value)
})

// Gestion des fichiers
function handleImageUpload(event) {
  const file = event.target.files[0]
  if (file) {
    localform.value.imageFile = file
    const reader = new FileReader()
    reader.onload = (e) => {
      localform.value.image = e.target.result
    }
    reader.readAsDataURL(file)
  }
}

// Ajouter / supprimer des raisons
function addItem() {
   if (!Array.isArray(localform.value.items)) {
    localform.value.items = []
  }
  localform.value.items.push({ text: '' })
}

function removeItem(index) {
  localform.value.items.splice(index, 1)
}
</script>
