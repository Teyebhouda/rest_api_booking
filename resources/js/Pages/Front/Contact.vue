<template>
  <div class="min-h-screen flex flex-col text-gray-800 bg-gradient-to-b from-gray-50 to-gray-100">
    <Navbar />
    <br /><br /><br /> <br /> <br />


    <main class="flex-1 relative overflow-hidden">
      <!-- Background animé -->
      <div class="absolute inset-0">
        <div class="absolute w-72 h-72 bg-primary/10 rounded-full blur-3xl top-10 left-10 animate-pulse"></div>
        <div class="absolute w-96 h-96 bg-secondary/10 rounded-full blur-3xl bottom-10 right-10 animate-ping"></div>
      </div>

      <section class="relative container mx-auto px-6 py-16 flex flex-col lg:flex-row items-center gap-12">
        <!-- Bloc informations -->
        <div class="w-full lg:w-1/2 space-y-8 animate-fadeInLeft">
          <h2 class="text-4xl font-extrabold text-gray-900 leading-tight">Restons en contact</h2>
          <p class="text-lg text-gray-600">
            Vous avez des questions ou un projet en tête ? Contactez-nous, nous vous répondrons rapidement.
          </p>
          <ul class="space-y-6">
            <li class="flex items-center gap-4">
              <Icon icon="mdi:office-building-outline" class="text-primary w-6 h-6" />
              <span class="font-medium">{{ $page.props.settings?.company_name }}</span>
            </li>
            <li class="flex items-center gap-4">
              <Icon icon="mdi:email-outline" class="text-primary w-6 h-6" />
              <a :href="`mailto:${$page.props.settings?.email}`" class="hover:text-secondary transition">
                {{ $page.props.settings?.email }}
              </a>
            </li>
            <li class="flex items-center gap-4">
              <Icon icon="mdi:phone" class="text-primary w-6 h-6" />
              <a :href="`tel:${$page.props.settings?.phone?.replace(/\s+/g, '')}`" class="hover:text-secondary transition">
                {{ $page.props.settings?.phone }}
              </a>
            </li>
            <li class="flex items-center gap-4">
              <Icon icon="mdi:map-marker-outline" class="text-primary w-6 h-6" />
              <span>{{ $page.props.settings?.adress }}</span>
            </li>
          </ul>
        </div>

        <!-- Formulaire -->
        <div class="w-full lg:w-1/2 bg-white shadow-xl rounded-2xl p-8 border border-gray-100 animate-fadeInRight">
          <h3 class="text-2xl font-semibold mb-6 text-gray-800">Envoyez-nous un message</h3>
          <form class="space-y-6" @submit.prevent="submitForm">
            <div>
              <label class="block mb-2 text-sm font-medium text-gray-700">Nom complet</label>
              <input
                v-model="form.nom"
                type="text"
                placeholder="Votre nom"
                class="w-full border border-gray-300 rounded-lg px-4 py-3 focus:ring-2 focus:ring-primary focus:outline-none"
                @blur="validateField('nom')"
              />
              <p v-if="errors.nom" class="text-red-500 text-sm mt-1">{{ errors.nom }}</p>
            </div>

            <div>
              <label class="block mb-2 text-sm font-medium text-gray-700">Email</label>
              <input
                v-model="form.email"
                type="email"
                placeholder="Votre email"
                class="w-full border border-gray-300 rounded-lg px-4 py-3 focus:ring-2 focus:ring-primary focus:outline-none"
                @blur="validateField('email')"
              />
              <p v-if="errors.email" class="text-red-500 text-sm mt-1">{{ errors.email }}</p>
            </div>

            <div>
              <label class="block mb-2 text-sm font-medium text-gray-700">Téléphone</label>
              <input
                v-model="form.telephone"
                type="tel"
                placeholder="Votre téléphone"
                class="w-full border border-gray-300 rounded-lg px-4 py-3 focus:ring-2 focus:ring-primary focus:outline-none"
                @blur="validateField('telephone')"
              />
              <p v-if="errors.telephone" class="text-red-500 text-sm mt-1">{{ errors.telephone }}</p>
            </div>

            <div>
              <label class="block mb-2 text-sm font-medium text-gray-700">Message</label>
              <textarea
                v-model="form.message"
                rows="5"
                placeholder="Votre message..."
                class="w-full border border-gray-300 rounded-lg px-4 py-3 focus:ring-2 focus:ring-primary focus:outline-none"
                @blur="validateField('message')"
              ></textarea>
              <p v-if="errors.message" class="text-red-500 text-sm mt-1">{{ errors.message }}</p>
            </div>

            <button
              type="submit"
              :disabled="loading || !isFormValid"
              class="w-full bg-primary text-white py-3 rounded-lg font-semibold hover:bg-primary/90 transition-all duration-300"
            >
              {{ loading ? 'Envoi...' : 'Envoyer' }}
            </button>
          </form>
        </div>

        <!-- Modale confirmation -->
        <div v-if="showModal" class="fixed inset-0 bg-black bg-opacity-70 flex items-center justify-center z-50 px-4">
        
          <div class="bg-white text-gray-800 rounded-2xl shadow-2xl p-8 sm:p-10 max-w-md w-full text-center relative">
              <!-- Logo centré en haut du modal -->
    <ApplicationLogo class="mx-auto h-16 w-auto mb-4" />
            <h2 class="text-2xl sm:text-3xl font-bold mb-4">Merci pour votre demande</h2>
            <p class="mb-6 text-gray-600">{{ modalMessage }}</p>
            <button
              @click="closeModal"
              class="bg-primary text-white py-3 px-8 rounded-full font-semibold hover:bg-indigo-700 focus:outline-none focus:ring-4 focus:ring-indigo-400 transition"
            >
              Fermer
            </button>
          </div>
        </div>
      </section>
    </main>

    <Footer />
  </div>
</template>

<script setup>
import Navbar from './Components/Navbar.vue'
import Footer from './Components/Footer.vue'
import { Icon } from '@iconify/vue'
import ApplicationLogo from '@/Components/ApplicationLogo.vue'
import { reactive, ref, computed, watch } from 'vue'
import axios from 'axios'

const loading = ref(false)
const showModal = ref(false)
const modalMessage = ref('Votre demande a bien été envoyée. Nous vous contacterons rapidement.')

const form = reactive({
  nom: '',
  email: '',
  telephone: '',
  message: ''
})

const errors = reactive({
  nom: '',
  email: '',
  telephone: '',
  message: ''
})

// Validation des champs
const validateField = (field) => {
  switch(field){
    case 'nom':
      errors.nom = form.nom.trim() ? '' : 'Le nom est requis.'
      break;
    case 'email':
      const emailPattern = /^[^\s@]+@[^\s@]+\.[^\s@]+$/
      if(!form.email.trim()) errors.email = 'L\'email est requis.'
      else if(!emailPattern.test(form.email)) errors.email = 'Email invalide.'
      else errors.email = ''
      break;
    case 'telephone':
      const phonePattern = /^\+?[0-9\s.-]{6,15}$/
      errors.telephone = form.telephone && !phonePattern.test(form.telephone) ? 'Téléphone invalide.' : ''
      break;
    case 'message':
      errors.message = form.message.trim() ? '' : 'Le message est requis.'
      break;
  }
}

const isFormValid = computed(() => {
  validateField('nom')
  validateField('email')
  validateField('telephone')
  validateField('message')
  return !errors.nom && !errors.email && !errors.telephone && !errors.message
})

watch(form, (newVal) => {
  Object.keys(newVal).forEach(field => validateField(field))
}, { deep: true })

const submitForm = async () => {
  if(!isFormValid.value) return

  loading.value = true
  try {
    const response = await axios.post(route('contact.sendcontact'), form, {
      headers: { 'X-CSRF-TOKEN': document.querySelector('meta[name="csrf-token"]').content }
    })
    if (response.data.success) {
      showModal.value = true
      Object.keys(form).forEach(key => form[key] = '')
    } else {
      modalMessage.value = 'Une erreur est survenue. Merci de réessayer.'
      showModal.value = true
    }
  } catch (error) {
    modalMessage.value = "Erreur lors de l'envoi. Merci de vérifier vos informations."
    showModal.value = true
  } finally {
    loading.value = false
  }
}

const closeModal = () => showModal.value = false
</script>

<style>
@keyframes fadeInLeft {
  from { opacity: 0; transform: translateX(-40px); }
  to { opacity: 1; transform: translateX(0); }
}
@keyframes fadeInRight {
  from { opacity: 0; transform: translateX(40px); }
  to { opacity: 1; transform: translateX(0); }
}
.animate-fadeInLeft { animation: fadeInLeft 1s ease-out forwards; }
.animate-fadeInRight { animation: fadeInRight 1s ease-out forwards; }
</style>
