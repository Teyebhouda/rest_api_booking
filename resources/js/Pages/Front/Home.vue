
<script setup>
import Navbar from './Components/Navbar.vue'
import Footer from './Components/Footer.vue'
import Hero from './Components/Hero.vue'
import Services from './Components/Services.vue'
import whyChooseUs from './Components/Whychoseus.vue'
import Contat_form from './Components/Contact_form.vue'
import Testimonials from './Components/Testimonials.vue'
import AboutUs from './Components/Aboutus.vue'
import Ourprojects from './Components/Ourprojects.vue'
import { computed } from 'vue'
import { usePage } from '@inertiajs/vue3'
import { ref, onMounted } from 'vue'
import ParallaxStats from './Components/parallaxStats.vue'
import Topbar from './Components/Topbar.vue'




const footerPages = computed(() => page.props.footerPages) // ✅ dispo direct



const contactSection = ref(null)
const selectedService = ref('')

// Fonction appelée au clic sur "Demander un devis"
const scrollToContact = (serviceName) => {
  selectedService.value = serviceName

  // Scroll vers la section via son ID
  const section = document.getElementById('contact-form')
  if (section) {
    section.scrollIntoView({ behavior: 'smooth' })
  }
}



const handleSelectService = (serviceId) => {
  selectedService.value = serviceId
}


const page = usePage()
const sections =computed(() => page.props.sections )



const heroContent = computed(() =>sections.value.hero?.content || {})
const aboutUsContent = computed(() => sections.value.aboutus?.content || {})
const servicesContent = computed(() =>sections.value.services?.content || {})
const projectsContent = computed(() =>sections.value.projects?.content || {})
const whyChooseUsContent = computed(() => sections.value.whyChooseUs?.content || {})
const testimonialsContent = computed(() =>sections.value.testimonials?.content || {})
const contactContent = computed(() =>sections.value.footer?.content || {})
const footerContent = computed(() =>sections.value.footer?.content || {})
const services = computed(() => sections.value.services?.content.items || [])
const projects = computed(() => sections.value.projects?.content.items || [])
const parallaxStatsContent = computed(() => sections.value.ParallaxStats?.content || {})
console.log('servicesitems', services.value)
console.log('projects_items', projects.value)


const scrollToTop = () => {
  window.scrollTo({ top: 0, behavior: 'smooth' })
}
onMounted(() => {
  window.addEventListener('scroll', () => {
    const btn = document.querySelector('.scroll-top-btn')
    if (btn) {
      if (window.scrollY > 300) {
        btn.classList.add('scroll-top-visible')
      } else {
        btn.classList.remove('scroll-top-visible')
      }
    }
  })
})

</script>
<template>
  <div class="min-h-screen flex flex-col text-gray-800">
   

    <!-- Header -->
   
   <Navbar :services="services" :projects="projects" />
 
    <!-- Contenu -->
<main class="flex-1">

    <Hero
  :content="heroContent"
  :services="services"
  @selectService="handleSelectService"
/>

 <ParallaxStats :content="parallaxStatsContent"   />
 

<Services
  :content="servicesContent"
  :scrollToContact="scrollToContact"
  :initialService="selectedService"
/>
     
        <whyChooseUs :content="whyChooseUsContent" /> 
      <!-- <Testimonials :content="testimonialsContent"/> -->
      <Ourprojects :content="projectsContent"/>
      
     
      <Contat_form :content="contactContent" :services="services" :initialService="selectedService" />
    </main>

    <!-- Footer -->
    <Footer :footerPages="footerPages" />  
    <button 
  @click="scrollToTop"
  class="scroll-top-btn fixed bottom-8 right-8 z-50"
  aria-label="Retour en haut"
>
</button>

  </div>



  
</template>

<style >
/* Transition oblique partagée entre deux sections */

/* Partie en bas de la première section */
.transition-slice-top {
  position: relative;
  width: 100%;
  height: 100px;
  clip-path: polygon(0 0, 100% 70%, 100% 100%, 0 100%);
}

/* Partie en haut de la deuxième section */
.transition-slice-bottom {
  position: relative;
  width: 100%;
  height: 100px;
  margin-top: -1px; /* pour supprimer l'espace entre sections */
  clip-path: polygon(0 0, 100% 0, 100% 30%, 0 100%);
}

/* Bouton "Retour en haut" */
/* Bouton "Retour en haut" – Version Premium Crystal + Material Rounded */
.scroll-top-btn {
  background: rgba(255, 255, 255, 0.25); /* Crystal glass */
  color: #000;
  width: 56px;
  height: 56px;
  border-radius: 20px;
  font-size: 1.4rem;
  font-weight: 700;
  display: flex;
  align-items: center;
  justify-content: center;
  cursor: pointer;

  /* CRYSTAL EDGE EFFECT */
  backdrop-filter: blur(16px);
  border: 1px solid rgba(255, 255, 255, 0.4);
  box-shadow:
    0 8px 25px rgba(0, 0, 0, 0.15),
    inset 0 2px 8px rgba(255, 255, 255, 0.808),
    inset 0 -2px 6px rgba(0, 0, 0, 0.05);

  transition: all 0.35s ease;
  transform: translateY(20px); /* Animation d'entrée */
  opacity: 0;
  pointer-events: none;
}

/* Apparition */
.scroll-top-visible {
  opacity: 1;
  pointer-events: auto;
  transform: translateY(0);
}

/* Hover — Effet luxe */
.scroll-top-btn:hover {
  transform: translateY(-6px) scale(1.06);
  box-shadow:
    0 14px 35px rgba(0, 0, 0, 0.25),
    inset 0 2px 10px rgba(255, 255, 255, 0.45),
    inset 0 -2px 8px rgba(0, 0, 0, 0.08);
}

/* Icône — Version sleek */
.scroll-top-btn::after {
  content: "↑";
  font-size: 1.4rem;
  font-weight: 900;
  color: #111;
}



</style>
