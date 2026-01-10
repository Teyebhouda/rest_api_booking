<script setup>
import { toRefs } from 'vue'

const props = defineProps({
  form: {
    type: Object
  }
})
const { form } = toRefs(props)

function addTestimonial() {
  if (!Array.isArray(form.value.items)) {
    form.value.items = [];
  }
  form.value.items.push({
    name: '',
    role: '',
    message: '',
    background_image: null, // Will hold base64 or file object
    imageFile: null // Store the file object
  });
}

function removeTestimonial(index) {
  form.value.items.splice(index, 1)
}

// Handle file input change
function handleImageUpload(event, testimonial) {
  const file = event.target.files[0];

  if (file) {
    testimonial.imageFile = file; // Stock le fichier brut
    const reader = new FileReader();
    reader.onload = (e) => {
      testimonial.background_image = e.target.result; // Base64 pour l'aperçu
    };
    reader.readAsDataURL(file);
  } else {
    testimonial.background_image = null;
    testimonial.imageFile = null;
  }
}

function submit() {
  console.log('Données soumises :', form.value)
}
</script>

<template>
  <div class="max-w-4xl mx-auto p-6 bg-white rounded shadow">
    <h2 class="text-2xl font-bold mb-6">Témoignages</h2>

    <label class="block mb-4">
      Titre :
      <input v-model="form.title" class="input mt-1" type="text" placeholder="Ex : Ce que disent nos utilisateurs" />
    </label>

    <div
      v-for="(testimonial, index) in form.items"
      :key="index"
      class="mb-6 border p-4 rounded"
    >
      <label class="block mb-2">
        Nom :
        <input v-model="testimonial.name" class="input mt-1" type="text" />
      </label>
      <label class="block mb-2">
        Rôle :
        <input v-model="testimonial.role" class="input mt-1" type="text" />
      </label>
      <label class="block mb-2">
        Message :
        <textarea v-model="testimonial.message" class="input mt-1"></textarea>
      </label>
      <div>
      <label class="block font-medium mb-1">Image de fond</label>
   <input
  type="file"
  :name="`items[${index}][imageFile]`"
  @change="(e) => handleImageUpload(e, testimonial)"
  class="block w-full border rounded p-2"
/>

      <div v-if="testimonial.background_image" class="mt-2">
        <img :src="testimonial.background_image" alt="Aperçu image" class="max-w-sm rounded" />
      </div>
    </div>
      <button type="button" @click="removeTestimonial(index)" class="text-red-500 mt-2">Supprimer</button>
    </div>

    <button type="button" @click="addTestimonial" class="bg-blue-500 text-white px-4 py-2 rounded mb-4">
      Ajouter un témoignage
    </button>

   
  </div>
</template>

<style scoped>
.input {
  @apply w-full border border-gray-300 p-2 rounded;
}
</style>
