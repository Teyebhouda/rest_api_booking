
<script setup>
import { reactive, ref, watch } from 'vue'
import { Inertia } from '@inertiajs/inertia'
import { defineProps } from 'vue'
import DashboardLayout from '@/Layouts/AuthenticatedLayout.vue'

// Import des composants de formulaire pour chaque section
import HeroSectionForm from './Partiels/HeroSectionForm.vue'
import ContactForm from './Partiels/ContactForm.vue'
import whyChooseUsForm from './Partiels/WhyChooseUs.vue'
import ServicesForm from './Partiels/Services.vue'
import TestimonialsForm from './Partiels/Testimonials.vue'
import AboutUs from './Partiels/AboutUs.vue'
import ParallaxStatsForm from './Partiels/ParallaxStatsForm.vue'
import ProjectsForm from './Partiels/Projects.vue'
import { toRaw } from 'vue'



// Props
const props = defineProps({
  sections: Object,
  settings: Object,
  allServices: Array,

})

// Liste des clés de sections disponibles
const sectionKeys = Object.keys(props.sections)
const activeSection = ref(sectionKeys[0] || '')

// Formulaire réactif
const form = reactive({})

// Associer les clés de section à leurs composants respectifs
const sectionComponents = {
  hero: HeroSectionForm,
  services: ServicesForm,
  projects: ProjectsForm,
  whyChooseUs: whyChooseUsForm,
  testimonials: TestimonialsForm,
  contact: ContactForm,
  ParallaxStats: ParallaxStatsForm,
  aboutus: AboutUs
}

// Charger les données de la section sélectionnée
// Charger les données d'une section
function loadSectionData(sectionKey) {
  const data = props.sections[sectionKey] || {}
  Object.keys(form).forEach(key => delete form[key])
  Object.assign(form, data)

  // Spécifique Hero : init slides avec existingImage
  if (sectionKey === 'hero' && Array.isArray(form.slides)) {
    form.slides = form.slides.map(slide => ({
      ...slide,
      imageFile: null,
      background_image: '',
      existingImage: slide.background_image || ''
    }))
  }
   // Spécifique Services
  if (sectionKey === 'services') {
    form.services_ids = Array.isArray(form.services_ids)
      ? form.services_ids
      : []   // 🔹 Assure toujours un tableau
  }

}
watch(activeSection, loadSectionData, { immediate: true })

// Soumission du formulaire
const processing = ref(false)

function submit() {
  processing.value = true
  const rawForm = toRaw(form)
  console.log('Soumission du formulaire pour la section :', activeSection.value)
  console.log('Données brutes du formulaire :', rawForm)
  const formData = new FormData()

  for (const key in rawForm) {
    const value = rawForm[key]

    // 1. Gestion spéciale pour hero.slides (tableau d’objets)
    if (key === 'slides' && Array.isArray(value)) {
      value.forEach((slide, idx) => {
        for (const subKey in slide) {
          const subValue = slide[subKey]

          if (subKey === 'imageFile') {
            // ✅ N'ajouter que si c'est un vrai fichier
            if (subValue instanceof File) {
              formData.append(`slides[${idx}][imageFile]`, subValue)
            }
          } else if (subKey === 'background_image') {
            // ✅ Ignorer background_image si imageFile existe (base64 inutile)
            if (!(slide.imageFile instanceof File)) {
              formData.append(`slides[${idx}][background_image]`, subValue)
            }
          } else {
            formData.append(`slides[${idx}][${subKey}]`, subValue)
          }
        }
      })
    }

    // 2. Cas tableau d’objets (ex: items[], steps[], etc.)
    else if (Array.isArray(value) && value.length > 0 && typeof value[0] === 'object') {
      value.forEach((item, index) => {
        for (const subKey in item) {
          const subValue = item[subKey]

          if (subKey === 'imageFile') {
            if (subValue instanceof File) {
              formData.append(`${key}[${index}][imageFile]`, subValue)
            }
          } else if (subKey === 'background_image') {
            if (!(item.imageFile instanceof File)) {
              formData.append(`${key}[${index}][background_image]`, subValue)
            }
          } else {
            formData.append(`${key}[${index}][${subKey}]`, subValue)
          }
        }
      })
    }

else if (key === 'services_ids' && Array.isArray(value)) {
  value.forEach((v, index) => {
    formData.append(`${key}[${index}]`, v)
  })
}


// 2bis. Cas tableau simple (ex: fields_to_show)
else if (Array.isArray(value)) {
  if (value.length > 0) {
    value.forEach((v, index) => {
      formData.append(`${key}[${index}]`, v)
    })
  }
}



    // 3. Fichier unique (ex: logoFile, imageFile à la racine)
    else if ((key === 'imageFile' || key === 'logoFile' || key === 'background_imageFile') && value instanceof File) {
      formData.append(key, value)
    }

    // 4. Objets simples (ex: footer.socials)
    else if (typeof value === 'object' && value !== null && !Array.isArray(value)) {
      if (key === 'socials') {
        try {
          formData.append(key, JSON.stringify(value))
        } catch (e) {
          console.warn(`Échec de la conversion JSON pour ${key}`, e)
        }
      } else {
        for (const subKey in value) {
          const subValue = value[subKey]

          if (subKey === 'imageFile') {
            if (subValue instanceof File) {
              formData.append(`${key}[imageFile]`, subValue)
            }
          } else if (subKey === 'background_image') {
            if (!(value.imageFile instanceof File)) {
              formData.append(`${key}[background_image]`, subValue)
            }
          } else {
            formData.append(`${key}[${subKey}]`, subValue)
          }
        }
      }
    }

    // 5. Champ background_image seul à la racine
    else if (key === 'background_image' && rawForm.imageFile instanceof File) {
      // Ignorer (on préfère imageFile)
      continue
    }

    // 6. Tous les autres champs simples (string, bool, etc.)
    else {
      formData.append(key, value)
    }
  }

  formData.append('_method', 'PUT')
for (let pair of formData.entries()) {
  console.log(pair[0], pair[1])
}
console.log(toRaw(form))
  Inertia.post(route('admin.homepage.update', activeSection.value), formData, {
    forceFormData: true,
    onFinish: () => {
      processing.value = false
    }
  })
}





// Formatage des labels
function formatLabel(key) {
  const labels = {
    hero: 'Bannière',
    contact: 'Infos de l\'entreprise',
    WhyChooseUs: 'Purquoi nous choisir',
    services: 'Services',
    projects: 'Projets',
    testimonials: 'Témoignages',
    aboutus: 'À propos de nous',
   parallaxStats: 'Section Parallax (statistiques)',
  }
  return labels[key] || key
}
</script>





<template>
  <DashboardLayout>
    <div class="flex min-h-screen bg-gray-100">
      <!-- Main content -->
        <!-- Sidebar avec les sections -->
      <aside class="w-64 bg-white shadow p-4">
        <h2 class="text-xl font-bold mb-4">Sections</h2>
        <ul class="space-y-2">
          <li
            v-for="key in sectionKeys"
            :key="key"
            @click="activeSection = key"
            class="cursor-pointer px-3 py-2 rounded hover:bg-blue-100"
            :class="{ 'bg-blue-500 text-white': activeSection === key }"
          >
            {{ formatLabel(key) }}
          </li>
        </ul>
      </aside>
      <main class="flex-1 p-8">
        <h1 class="text-2xl font-bold mb-6">Modifier la section : {{ formatLabel(activeSection) }}</h1>

        <form @submit.prevent="submit">
          <!-- Chargement du bon composant selon la section -->
         
 <component
  :is="sectionComponents[activeSection]"
  :form="form"
  @update:form="Object.assign(form, $event)"  
  :allServices="props.allServices"
  :allProjects="props.AllProjects"
  v-bind="activeSection === 'contact' ? { settings } : {}"
/>


          <button
            type="submit"
            class="mt-6 px-6 py-2 bg-blue-600 text-white rounded hover:bg-blue-700"
            :disabled="processing"
          >
            {{ processing ? 'Enregistrement...' : 'Enregistrer' }}
          </button>
        </form>
      </main>

     
    </div>
  </DashboardLayout>
</template>
