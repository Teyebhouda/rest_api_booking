<script setup>
import { reactive, ref } from 'vue'
import { Inertia } from '@inertiajs/inertia'
import DashboardLayout from '@/Layouts/AuthenticatedLayout.vue'

const props = defineProps({
  settings: Object
})

// ✅ Utiliser reactive correctement (sans .value)
const form = reactive({
  company_name: props.settings.company_name || '',
  email: props.settings.email || '',
  phone: props.settings.phone || '',
  adress: props.settings.adress || '',
  map_embed: props.settings.map_embed || '',
  logo: props.settings.logo || '',
  logoFile: null,
  meta_title: props.settings.meta_title || '',
  meta_description: props.settings.meta_description || '',
  meta_keywords: props.settings.meta_keywords || '',
  socials: props.settings.socials ? JSON.parse(props.settings.socials) : {},
})

const processing = ref(false)
const newSocialKey = ref('')
const activeSection = ref('company') // section active par défaut

function addSocial() {
  const key = newSocialKey.value.trim().toLowerCase()
  if (key && !form.socials?.[key]) {
    form.socials[key] = ''
    newSocialKey.value = ''
  }
}

function removeSocial(key) {
  delete form.socials[key]
}

// Gestion du logo
function handleLogoUpload(event) {
  const file = event.target.files[0]
  if (file) {
    form.logoFile = file
    const reader = new FileReader()
    reader.onload = e => {
      form.logo = e.target.result
    }
    reader.readAsDataURL(file)
  }
}

function capitalize(str) {
  return str.charAt(0).toUpperCase() + str.slice(1)
}

function submit() {
  processing.value = true
  const payload = { ...form, socials: JSON.stringify(form.socials) }
  Inertia.post(route('settings.update'), payload, {
    onFinish: () => {
      processing.value = false
    }
  })
}
</script>

<template>
  <DashboardLayout>
    <div class="flex min-h-screen bg-gray-100">
      <!-- Aside -->
      <aside class="w-64 bg-white shadow p-4">
        <h2 class="text-xl font-medium mb-4">Paramètres</h2>
        <ul>
          <li>
            <button
              @click="activeSection = 'company'"
              class="block w-full text-left py-2 px-2 rounded hover:bg-gray-200"
              :class="activeSection === 'company' ? 'bg-gray-200 font-semibold' : ''"
            >
              Paramètres de l'entreprise
            </button>
          </li>
          <li>
            <button
              @click="activeSection = 'seo'"
              class="block w-full text-left py-2 px-2 rounded hover:bg-gray-200"
              :class="activeSection === 'seo' ? 'bg-gray-200 font-semibold' : ''"
            >
              SEO
            </button>
          </li>
        </ul>
      </aside>

      <!-- Main -->
      <main class="flex-1 p-8">
        <h1 class="text-2xl font-bold mb-6">Modifier les paramètres</h1>
        <form class="space-y-6" @submit.prevent="submit">
          
          <!-- Section Entreprise -->
          <div v-if="activeSection === 'company'">
            <div>
              <label class="block font-medium mb-1">Logo</label>
              <input type="file" @change="handleLogoUpload" accept="image/*" />
              <div v-if="form.logo" class="mt-2">
                <img :src="form.logo" alt="Aperçu du logo" class="max-w-xs rounded shadow" />
              </div>
            </div>
            <div>
              <label class="block font-medium mb-1">Nom de l'entreprise</label>
              <input type="text" v-model="form.company_name" class="w-full border rounded px-3 py-2" />
            </div>
            <div>
              <label class="block font-medium mb-1">Email</label>
              <input type="email" v-model="form.email" class="w-full border rounded px-3 py-2" />
            </div>
            <div>
              <label class="block font-medium mb-1">Téléphone</label>
              <input type="text" v-model="form.phone" class="w-full border rounded px-3 py-2" />
            </div>
            <div>
              <label class="block font-medium mb-1">Adresse</label>
              <textarea v-model="form.adress" rows="2" class="w-full border rounded px-3 py-2"></textarea>
            </div>

            <div>
              <label class="block font-medium mb-1">Code d'intégration de la carte</label>
              <textarea v-model="form.map_embed" rows="3" class="w-full border rounded px-3 py-2"></textarea>
            </div>
            

            <!-- Réseaux sociaux dynamiques -->
            <div>
              <label class="block font-medium mb-2">Réseaux sociaux</label>
              <div
                v-for="(value, key) in form.socials"
                :key="key"
                class="mb-2 flex items-center space-x-2"
              >
                <input
                  v-model="form.socials[key]"
                  :placeholder="`Lien vers ${capitalize(key)}`"
                  class="w-full border rounded px-3 py-2 flex-1"
                />
                <button @click="removeSocial(key)" type="button" class="text-red-500 hover:underline">
                  Supprimer
                </button>
              </div>
              <div class="flex items-center space-x-2 mt-2">
                <input v-model="newSocialKey" placeholder="Nom du réseau (ex: twitter)" class="w-full border rounded px-3 py-2" />
                <button @click="addSocial" type="button" class="bg-gray-200 px-3 py-2 rounded hover:bg-gray-300">+ Ajouter</button>
              </div>
            </div>
          </div>

          <!-- Section SEO -->
          <div v-if="activeSection === 'seo'">
            <div>
              <label class="block font-medium mb-1">Meta Title</label>
              <input type="text" v-model="form.meta_title" class="w-full border rounded px-3 py-2" />
            </div>
            <div>
              <label class="block font-medium mb-1">Meta Description</label>
              <textarea v-model="form.meta_description" class="w-full border rounded px-3 py-2"></textarea>
            </div>
            <div>
              <label class="block font-medium mb-1">Meta Keywords</label>
              <input type="text" v-model="form.meta_keywords" class="w-full border rounded px-3 py-2" />
            </div>
          </div>

          <!-- Submit -->
          <button type="submit" class="bg-blue-600 text-white px-6 py-2 rounded" :disabled="processing">
            {{ processing ? 'Enregistrement...' : 'Enregistrer' }}
          </button>
        </form>
      </main>
    </div>
  </DashboardLayout>
</template>
