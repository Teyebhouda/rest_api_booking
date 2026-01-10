<template>
  <section
    class="relative bg-center bg-cover bg-fixed contact-section py-16 px-4 sm:py-20 sm:px-8 lg:px-12"
    role="region"
    aria-labelledby="contact-title"
    ref="contactSection"
    id="contact-form"
  >
  
    <!-- Overlay -->
<div class="absolute inset-0 z-0 pointer-events-none">
  <!-- Couche 1 : noir doux -->
  <div class="absolute inset-0 bg-black/30"></div>
  <!-- Couche 2 : filtre primary -->
  <div class="absolute inset-0 bg-primary/40 mix-blend-overlay backdrop-blur-sm"></div>
</div>




    <!-- Contenu -->
    <div class="relative z-10 max-w-screen-xl mx-auto grid grid-cols-1 lg:grid-cols-2 gap-12 lg:gap-20">
      
      <!-- Bloc gauche (texte) -->
      <div class="text-white">
        <h2 id="contact-title" class="text-3xl sm:text-4xl md:text-5xl font-extrabold mb-6 leading-tight">
          Transformez vos idées en <span class="text-secondary">réalité</span>
        </h2>
        <div class="w-12 h-1 bg-secondary mt-3 rounded-full mb-8" aria-hidden="true"></div>
        <p class="text-base sm:text-lg leading-relaxed">
          Que vous ayez un projet concret ou juste une idée, notre équipe est prête à vous accompagner à chaque étape.
        </p>
        <p class="mt-3 italic text-gray-300 text-sm sm:text-base">
          Ensemble, donnons vie à votre vision avec créativité et expertise.
        </p>
      </div>

      <!-- Bloc droit (formulaire) -->
      <div class="relative overflow-visible max-h-[90vh] lg:max-h-none pr-4 sm:pr-6">
        
      <!-- Étape 0 -->
<div v-if="step === 0" class="space-y-6 pb-8 flex flex-col items-center text-center h-full justify-center">
 
  <p class="text-gray-100 text-base sm:text-lg max-w-sm">
    Dites-nous ce que vous avez en tête. Nous vous répondrons rapidement avec des idées concrètes !
  </p>

  <button
    @click="step = 1"
    class="px-6 py-3 bg-primary text-white font-semibold rounded-xl shadow-md hover:bg-primary/90 hover:-translate-y-1 transition transform duration-300 focus:outline-none focus:ring-2 focus:ring-primary/70"
    aria-label="Commencer une demande de projet"
  >
    Faire une demande
  </button>
</div>


        <!-- Étape 1 : choix service -->
        <transition name="fade" mode="out-in">
          <div v-if="step === 1" class="space-y-6 sm:space-y-8 pb-10">
            <h3 class="text-xl sm:text-2xl font-semibold text-gray-800 mb-4">Quel type de projet ?</h3>
            <div class="grid grid-cols-1 sm:grid-cols-2 gap-4 sm:gap-6">
              <button
                v-for="(type, index) in services"
                :key="index"
                @click="form.service = type.title"
                :class="[ 
                  'py-3 sm:py-4 px-4 sm:px-6 rounded-xl border font-semibold text-left transition-all duration-300 w-full transform origin-center',
                  form.service === type.title
                    ? 'bg-primary text-white border-primary shadow-lg hover:shadow-xl'
                    : 'bg-gray-100 hover:bg-gray-200 text-gray-700 border-gray-300 hover:shadow-md hover:-translate-y-1'
                ]"
                :aria-pressed="form.service === type.title"
              >
                {{ type.title }}
              </button>
            </div>
            <p v-if="errors.service" class="text-red-500 text-sm mt-1">{{ errors.service }}</p>
            <div class="text-right mt-4 sm:mt-6">
              <button
                :disabled="!form.service"
                @click="step++"
                class="bg-primary text-white py-3 px-6 sm:px-8 rounded-full font-semibold shadow-md disabled:opacity-50 disabled:cursor-not-allowed hover:bg-indigo-700 transition duration-300"
              >
                Suivant
              </button>
            </div>
          </div>
        </transition>

        <!-- Étape 2 : message projet -->
        <transition name="fade" mode="out-in">
          <div v-if="step === 2" class="space-y-6 sm:space-y-8 pb-10">
            <h3 class="text-xl sm:text-2xl font-semibold text-gray-800 mb-4">Parlez-nous de votre projet</h3>
            <textarea
              v-model="form.message"
              rows="5"
              placeholder="Décrivez votre projet ici..."
              class="w-full p-4 sm:p-5 rounded-xl bg-gray-50 border border-gray-300 text-gray-800 placeholder-gray-400 focus:outline-none focus:ring-4 focus:ring-secondary/30 transition"
              @blur="validateField('message')"
            ></textarea>
            <p v-if="errors.message" class="text-red-500 text-sm mt-1">{{ errors.message }}</p>
            <div class="flex justify-between items-center mt-2 sm:mt-4">
              <button
                @click="step--"
                class="text-sm text-gray-800 underline hover:text-gray-900 focus:outline-none focus:ring-2 focus:ring-secondary rounded"
              >
                Précédent
              </button>
              <button
                :disabled="!form.message"
                @click="step++"
                class="bg-primary text-white py-3 px-6 sm:px-8 rounded-full font-semibold shadow-md disabled:opacity-50 disabled:cursor-not-allowed hover:bg-secondary-700 transition duration-300"
              >
                Suivant
              </button>
            </div>
          </div>
        </transition>

        <!-- Étape 3 : coordonnées -->
        <transition name="fade" mode="out-in">
          <div v-if="step === 3" class="space-y-6 sm:space-y-8 pb-10">
            <h3 class="text-xl sm:text-2xl font-semibold text-gray-800 mb-4">Vos coordonnées</h3>
            <div class="grid grid-cols-1 md:grid-cols-2 gap-4 sm:gap-6">
              <div>
                <input
                  v-model="form.nom"
                  type="text"
                  placeholder="Nom complet"
                  class="input w-full"
                  @blur="validateField('nom')"
                />
                <p v-if="errors.nom" class="text-red-500 text-sm mt-1">{{ errors.nom }}</p>
              </div>
              <div>
                <input
                  v-model="form.email"
                  type="email"
                  placeholder="Email"
                  class="input w-full"
                  @blur="validateField('email')"
                />
                <p v-if="errors.email" class="text-red-500 text-sm mt-1">{{ errors.email }}</p>
              </div>
              <div>
                <input
                  v-model="form.telephone"
                  type="tel"
                  placeholder="Téléphone"
                  class="input w-full"
                  @blur="validateField('telephone')"
                />
                <p v-if="errors.telephone" class="text-red-500 text-sm mt-1">{{ errors.telephone }}</p>
              </div>
              <div>
                <input
                  v-model="form.entreprise"
                  type="text"
                  placeholder="Entreprise"
                  class="input w-full"
                  @blur="validateField('entreprise')"
                />
                <p v-if="errors.entreprise" class="text-red-500 text-sm mt-1">{{ errors.entreprise }}</p>
              </div>

            </div>
            <div class="flex justify-between items-center mt-2 sm:mt-4">
              <button
                @click="step--"
                class="text-sm text-gray-800 underline hover:text-gray-900 focus:outline-none focus:ring-2 focus:ring-secondary rounded"
              >
                Précédent
              </button>
              <button
                @click="submitForm"
                :disabled="loading || !isFormValid"
                class="bg-primary text-white py-3 px-6 sm:px-8 rounded-full font-semibold shadow-md disabled:opacity-50 disabled:cursor-not-allowed hover:bg-indigo-700 transition duration-300 flex items-center justify-center"
              >
                <span v-if="loading" class="animate-spin mr-2 border-2 border-white border-t-transparent rounded-full w-5 h-5"></span>
                {{ loading ? 'Envoi...' : 'Envoyer' }}
              </button>
            </div>
          </div>
        </transition>
      </div>
    </div>

    <!-- Modale confirmation -->
    <div
      v-if="showModal"
      class="fixed inset-0 bg-black bg-opacity-70 flex items-center justify-center z-50 px-4"
    >
     
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
</template>

<script setup>
import { reactive, ref, computed, watch } from 'vue'
import axios from 'axios'
import ApplicationLogo from '@/Components/ApplicationLogo.vue'

const props = defineProps({
  services: { type: Array, default: () => [] },
})

const step = ref(0)
const loading = ref(false)
const showModal = ref(false)
const modalMessage = ref('Votre demande a bien été envoyée. Nous vous contacterons rapidement.')

const form = reactive({
  nom: '',
  email: '',
  telephone: '',
  entreprise: '',
  service: '',
  message: ''
})

const errors = reactive({
  nom: '',
  email: '',
  telephone: '',
  service: '',
  message: ''
})

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
  if (!form.telephone.trim()) {
    errors.telephone = 'Le téléphone est requis.'
  } else if (!phonePattern.test(form.telephone)) {
    errors.telephone = 'Téléphone invalide.'
  } else {
    errors.telephone = ''
  }
  break;

    case 'service':
      errors.service = form.service ? '' : 'Veuillez choisir un service.'
      break;
    case 'message':
      errors.message = form.message.trim() ? '' : 'Le message est requis.'
      break;
    case 'entreprise':
      errors.entreprise = form.entreprise.trim() ? '' : 'Le nom de l\'entreprise est requis.'
      break;
  }
}

const isFormValid = computed(() => {
  validateField('nom')
  validateField('email')
  validateField('telephone')
  validateField('service')
  validateField('message')
  validateField('entreprise')
  return !errors.nom && !errors.email && !errors.telephone && !errors.service && !errors.message && !errors.entreprise
})

watch(form, (newVal) => {
  Object.keys(newVal).forEach(field => validateField(field))
}, { deep: true })

const submitForm = async () => {
  if(!isFormValid.value) return

  loading.value = true
  try {
    const response = await axios.post(route('contact.send'), form, {
      headers: { 'X-CSRF-TOKEN': document.querySelector('meta[name="csrf-token"]').content }
    })
    if (response.data.success) {
      showModal.value = true
      Object.keys(form).forEach(key => form[key] = '')
      step.value = 0
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

<style scoped>
.input {
  background-color: #f9fafb;
  border: 1px solid #d1d5db;
  padding: 0.75rem;
  border-radius: 0.75rem;
  color: #111827;
  transition: all 0.3s ease;
}
.input:focus {
  border-color: #f97316;
  box-shadow: 0 0 0 4px rgba(249,115,22,0.2);
  outline: none;
}

.fade-enter-active, .fade-leave-active {
  transition: all 0.4s ease;
}
.fade-enter-from { opacity: 0; transform: translateY(20px); }
.fade-leave-to { opacity: 0; transform: translateY(-10px); }
.fade-enter-to, .fade-leave-from { opacity: 1; transform: translateY(0); }

.contact-section {
  background-image: url('/images/bg-12.jpg');
  background-size: cover;
  background-position: center;
  background-repeat: no-repeat;
  background-attachment: fixed;
}
</style>
