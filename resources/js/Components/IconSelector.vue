<script setup>
import Multiselect from '@vueform/multiselect'
import { Icon } from '@iconify/vue'
import '@vueform/multiselect/themes/default.css'

const props = defineProps({
  modelValue: String,
})

const emit = defineEmits(['update:modelValue'])

// Liste étendue des icônes (tu peux ajouter jusqu’à 100+ si tu veux)
const iconOptions = [
  'mdi:school',
  'mdi:account',
  'mdi:account-group',
  'mdi:calendar',
  'mdi:calendar-clock',
  'mdi:email',
  'mdi:email-edit-outline',
  'mdi:office-building-outline',
  'mdi:map-marker',
  'mdi:home-city-outline',
  'mdi:bullhorn',
  'mdi:palette',
  'mdi:human-male-board',
  'mdi:book-open-variant',
  'mdi:briefcase-outline',
  'mdi:chart-areaspline',
  'mdi:account-cog',
  'mdi:folder-settings-outline',
  'mdi:head-cog-outline',
  'mdi:desktop-classic',
  'mdi:calculator',
  'mdi:file-document-outline',
  'mdi:passport',
  'mdi:chart-box-outline',
  'mdi:scale-balance',
  'mdi:cloud-outline',
  'mdi:cloud-download-outline',
  'mdi:lock-outline',
  'mdi:lock-open-outline',
  'mdi:shield-account',
  'mdi:web',
  'mdi:web-check',
  'mdi:database',
  'mdi:server',
  'mdi:bell-outline',
  'mdi:phone',
  'mdi:cellphone',
  'mdi:earth',
  'mdi:language-html5',
  'mdi:language-css3',
  'mdi:language-javascript',
  'mdi:language-php',
  'mdi:vuejs',
  'mdi:react',
  'mdi:laravel',
  'mdi:github',
  'mdi:linkedin',
  'mdi:twitter',
  'mdi:instagram',
]


// Transformer chaque icône en option `{ label, value }`
const options = iconOptions.map(icon => ({
  label: icon,
  value: icon,
}))
</script>

<template>
  <div>
    <label class="block mb-2 text-sm font-medium text-gray-700">Choisir une icône</label>

    <Multiselect
      v-model="props.modelValue"
      :options="options"
      :option-height="40"
      placeholder="Sélectionner une icône"
      searchable
      label="label"
      track-by="value"
      @update:modelValue="emit('update:modelValue', $event)"
    >
      <!-- Affichage dans l'input sélectionné -->
      <template #singleLabel="{ option }">
        <Icon :icon="option.value" class="inline mr-2 text-lg" />
        {{ option.label }}
      </template>

      <!-- Affichage dans le menu déroulant -->
      <template #option="{ option }">
        <div class="flex items-center gap-2">
          <Icon :icon="option.value" class="text-lg" />
          <span>{{ option.label }}</span>
        </div>
      </template>
    </Multiselect>

    <!-- Aperçu -->
    <div class="mt-4 text-gray-600 text-sm">
      Icône sélectionnée :
      <Icon :icon="props.modelValue" class="inline ml-2 text-2xl align-middle" v-if="props.modelValue" />
    </div>
  </div>
</template>
