<script setup>
import { ref, watch, onMounted } from 'vue'
import { Inertia } from '@inertiajs/inertia'
import { defineProps, defineEmits } from 'vue'

const props = defineProps({
  form: Object,
  settings: Object // tous les settings disponibles
})
const emit = defineEmits(['update:form'])

const availableFields = Object.keys(props.settings || {})
//const selectedFields = ref(props.form.fields_to_show ?? [])
// Sync bidirectionnelle
/*watch(selectedFields, (val) => {
  emit('update:form', { ...props.form, fields_to_show: val })
})*/

// Initialisation des champs à afficher si non définis
onMounted(() => {
  if (!props.form.fields_to_show) {
    emit('update:form', { ...props.form, fields_to_show: selectedFields.value })
  }
})
</script>

<template>
  <form class="space-y-6">
  <div>
    <h3 class="font-bold mb-2">Champs à afficher dans le contact section</h3>
    <div class="space-y-2">
      <label
        v-for="field in availableFields"
        :key="field"
        class="flex items-center space-x-2"
      >
        <input
          type="checkbox"
          :value="field"
         v-model="form.fields_to_show"
          class="form-checkbox h-4 w-4 text-blue-600 border-gray-300 rounded focus:ring-blue-500"
        />
        <span>{{ field }}</span>
      </label>
    </div>
  </div>
 </form>
</template>