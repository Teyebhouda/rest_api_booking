<template>
  <form class="space-y-6">
    <div class="text-center">
      <input v-model="localForm.title" type="text" placeholder="Titre de la section" class="input text-4xl font-extrabold mb-2 w-full text-center" />
      <input v-model="localForm.subtitle" type="text" placeholder="Sous-titre de la section" class="input text-lg mb-4 w-full text-center" />
      <textarea v-model="localForm.description" type="text" rows="3"
        class="w-full border rounded p-2 focus:ring focus:ring-blue-300"
        placeholder="Une description courte de la section"  />
    </div>
    <!-- Section: Services -->
   
    <!-- Liste des services existants -->
    <div>
      <h3 class="font-semibold mb-2">Choisir les services à afficher</h3>

      <!-- ✅ Case tout sélectionner -->
      <div class="flex items-center mb-3">
        <input
          type="checkbox"
          :checked="allSelected"
          @change="toggleAll"
          class="mr-2"
        />
        <span class="font-medium">Tout sélectionner</span>
      </div>

      <!-- ✅ Sécurisé pour éviter undefined.id -->
      <div
        v-for="service in allServices"
        :key="service.id"
        class="flex items-center mb-2"
      >
        <input
          type="checkbox"
          :value="Number(service.id)"
          v-model="localForm.services_ids"
          class="mr-2"
        />
        <span>{{ service.title }}</span>
      </div>
    </div>
  </form>
</template>

<script setup>
import { reactive, watch, computed } from 'vue'

const props = defineProps({
  form: { type: Object, required: true },
  allServices: { type: Array, default: () => [] },
})

const emit = defineEmits(['update:form'])

// Initialisation unique
const localForm = reactive({
  title: props.form.title || '',
  subtitle: props.form.subtitle || '',
  services_ids: Array.isArray(props.form.services_ids)
    ? props.form.services_ids.map(Number)
    : [],
})

// Vérifie si tout est sélectionné
const allSelected = computed(() =>
  props.allServices.length > 0 &&
  localForm.services_ids.length === props.allServices.length
)

// Action tout sélectionner / tout décocher
const toggleAll = () => {
  if (allSelected.value) {
    localForm.services_ids = []
  } else {
    localForm.services_ids = props.allServices.map(s => Number(s.id))
  }
}

// Synchronisation locale → parent (fusion propre)
watch(
  localForm,
  (newVal) => {
    for (const key in newVal) {
      emit('update:form', { [key]: newVal[key] })
    }
  },
  { deep: true }
)

</script>

