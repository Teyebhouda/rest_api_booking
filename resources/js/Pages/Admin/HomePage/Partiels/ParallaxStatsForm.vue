<template>
  <div class="space-y-6">
    <!-- Titre -->
    <div>
      <label class="block text-gray-700 font-semibold mb-1">Titre</label>
      <input
        v-model="form.title"
        type="text"
        class="w-full border rounded p-2 focus:ring focus:ring-blue-300"
        placeholder="Titre de la section"
      />
    </div>

    <!-- Description -->
    <div>
      <label class="block text-gray-700 font-semibold mb-1">Description</label>
      <textarea
        v-model="form.description"
        rows="3"
        class="w-full border rounded p-2 focus:ring focus:ring-blue-300"
        placeholder="Une description courte de votre section..."
      ></textarea>
    </div>

    <!-- Image de fond -->
    <div>
      <label class="block text-gray-700 font-semibold mb-1">Image de fond</label>
      <input type="file" @change="handleFile($event, 'background_image')" class="block w-full text-sm mb-2" />
      <img v-if="previews.background_image" :src="previews.background_image" class="w-48 h-auto rounded border" />
    </div>

    <!-- Image décorative -->
    <div>
      <label class="block text-gray-700 font-semibold mb-1">Image décorative</label>
      <input type="file" @change="handleFile($event, 'image')" class="block w-full text-sm mb-2" />
      <img v-if="previews.image" :src="previews.image" class="w-48 h-auto rounded border" />
    </div>

    <!-- Badge -->
    <div>
      <label class="block text-gray-700 font-semibold mb-1">Badge</label>
      <input
        v-model="form.badge"
        type="text"
        class="w-full border rounded p-2 focus:ring focus:ring-blue-300"
        placeholder="Badge (ex: +10 ans d’expérience)"
      />
    </div>

    <!-- Statistiques -->
    <div>
      <label class="block text-gray-700 font-semibold mb-2">Statistiques</label>

      <!-- Liste des stats -->
      <div
        v-for="(stat, index) in form.stats"
        :key="index"
        class="flex gap-2 mb-2 items-center"
      >
        <input
          v-model="stat.value"
          type="text"
          placeholder="Valeur (ex: 100+)"
          class="border rounded p-2 flex-1 focus:ring focus:ring-blue-300"
        />
        <input
          v-model="stat.label"
          type="text"
          placeholder="Label (ex: Projets réalisés)"
          class="border rounded p-2 flex-1 focus:ring focus:ring-blue-300"
        />
        <button
          type="button"
          @click="removeStat(index)"
          class="px-3 py-1 bg-red-500 hover:bg-red-600 text-white rounded"
        >
          -
        </button>
      </div>

      <!-- Bouton ajouter -->
      <button
        type="button"
        @click="addStat"
        class="px-4 py-2 bg-blue-600 hover:bg-blue-700 text-white rounded"
      >
        + Ajouter
      </button>
    </div>
  </div>
</template>

<script setup>
import { reactive, watchEffect } from "vue"

const props = defineProps({
  form: { type: Object, required: true }
})

// Sécuriser form.stats
if (!Array.isArray(props.form.stats)) {
  props.form.stats = reactive([])
}

// Aperçus d'images
const previews = reactive({
  background_image: props.form.background_image || null,
  image: props.form.image || null,
})

function handleFile(event, key) {
  const file = event.target.files[0]
  if (file) {
    props.form[`${key}File`] = file
    previews[key] = URL.createObjectURL(file)
  }
}

function addStat() {
  props.form.stats.push({ value: "", label: "" })
}

function removeStat(index) {
  props.form.stats.splice(index, 1)
}
</script>
