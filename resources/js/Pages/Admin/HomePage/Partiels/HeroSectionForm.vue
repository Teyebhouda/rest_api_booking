<script setup>
import { toRefs } from 'vue'

const props = defineProps({
  form: {
    type: Object,
    required: true
  }
})

const { form } = toRefs(props)

// Initialiser les slides si absents
if (!form.value.slides) {
  form.value.slides = [
    {
      title: '',
      subtitle: '',
      button_text: '',
      existingImage: '/images/default.jpg', // ✅ image déjà enregistrée
      background_image: '', // ✅ preview temporaire
      imageFile: null
    }
  ]
}

function addSlide() {
  form.value.slides.push({
    title: '',
    subtitle: '',
    button_text: '',
    existingImage: '', // si pas encore dans la BDD
    background_image: '',
    imageFile: null
  })
}

function removeSlide(index) {
  form.value.slides.splice(index, 1)
}

function handleImageUpload(event, slide) {
  const file = event.target.files[0]
  if (file) {
    slide.imageFile = file
    const reader = new FileReader()
    reader.onload = e => {
      slide.background_image = e.target.result
    }
    reader.readAsDataURL(file)
  } else {
    // Ne touche pas à existingImage, juste reset l'upload
    slide.imageFile = null
    slide.background_image = ''
    // Do NOT clear existingImage unless explicitly requested
  }
}

</script>

<template>
  <div class="space-y-8">
    <div
      v-for="(slide, index) in form.slides"
      :key="index"
      class="border rounded-xl p-6 bg-gray-50 relative"
    >
      <button
        v-if="form.slides.length > 1"
        type="button"
        class="absolute top-4 right-4 text-red-500 hover:text-red-700"
        @click="removeSlide(index)"
        title="Supprimer ce slide"
      >
        &times;
      </button>

      <div class="grid gap-4">
        <label>
          Titre du slide
          <input v-model="slide.title" type="text" class="input" />
        </label>
        <label>
          Sous-titre
          <textarea v-model="slide.subtitle" class="input" />
        </label>
        <label>
          Texte du bouton
          <input v-model="slide.button_text" type="text" class="input" />
        </label>

        <div>
          <label class="block font-medium mb-1">Image de fond</label>
          <input
            type="file"
            accept="image/*"
            @change="e => handleImageUpload(e, slide)"
            class="block w-full border rounded p-2"
          />

          <!-- ✅ Aperçu : si une nouvelle image a été choisie -->
          <div v-if="slide.background_image" class="mt-2">
            <img
              :src="slide.background_image"
              alt="Nouvelle image"
              class="max-w-xs rounded shadow"
            />
          </div>

          <!-- ✅ Sinon afficher l’image déjà existante -->
          <div v-else-if="slide.existingImage" class="mt-2">
            <img
              :src="slide.existingImage"
              alt="Image existante"
              class="max-w-xs rounded shadow"
            />
          </div>
        </div>
      </div>
    </div>

    <button
      type="button"
      class="bg-blue-600 text-white px-4 py-2 rounded hover:bg-blue-700 transition"
      @click="addSlide"
    >
      Ajouter un slide
    </button>
  </div>
</template>

<style scoped>
.input {
  @apply w-full border border-gray-300 p-2 rounded;
}
</style>
