<template>
  <section
    id="about"
    class="relative bg-gray-50 py-24 overflow-hidden"
    aria-labelledby="about-title"
  >
    <!-- Décorations de fond -->
    <div
      class="absolute inset-0 bg-cover bg-center opacity-20 blur-sm pointer-events-none select-none"
      style="background-image: url('/images/bg-12.jpg');"
      aria-hidden="true"
    ></div>
    <div
      class="absolute bottom-0 right-0 w-96 h-96 bg-indigo-100 rounded-full blur-3xl opacity-40 -z-10 pointer-events-none select-none"
      aria-hidden="true"
    ></div>

    <div
      class="max-w-7xl mx-auto px-6 lg:px-12 grid lg:grid-cols-2 gap-16 items-center"
    >
      <!-- Texte principal -->
      <div class="space-y-8 animate-fadeInLeft" tabindex="0">
      

        <h2
          id="about-title"
          class="text-4xl md:text-5xl font-extrabold text-gray-900 leading-tight max-w-3xl"
        >
          {{ content.title }}
        </h2>
          <h4
          id="about-subtitle"
          class="text-sm font-semibold tracking-widest uppercase"
        >
          {{ content.subtitle }}
        </h4> 

        <div
          v-html="content.long_description"
          class="prose prose-indigo prose-lg max-w-none text-gray-700"
        ></div>

     <!--   <div>
          <a
            href="#services"
            class="inline-block rounded-full bg-blue-600 px-10 py-4 text-white font-semibold shadow-lg transition duration-300 ease-in-out hover:bg-blue-700 hover:scale-105 focus:outline-none focus:ring-4 focus:ring-blue-300"
          >
            Découvrir nos services
          </a>
        </div>-->
      </div>  

      <!-- Image illustrative -->
      <div class="animate-fadeInRight" tabindex="0" aria-label="Image illustrative">
        <img
          :src="content.image"
          alt="À propos de nous"
          class="rounded-xl shadow-xl w-full object-cover max-h-[480px]"
          loading="lazy"
          decoding="async"
        />
      </div>
    </div>
  </section>
</template>

<script setup>
defineProps({
  content: {
    type: Object,
    default: () => ({
      subtitle: "À propos de nous",
      title: "Construisons l’avenir avec expertise et passion",
      long_description: `
        <p>
          Depuis plus de 10 ans, notre entreprise de construction combine savoir-faire artisanal et innovation technique pour réaliser vos projets en toute confiance.
        </p>
        <ul>
          <li>Qualité et durabilité garanties sur chaque chantier</li>
          <li>Projets sur mesure, adaptés à vos besoins</li>
          <li>Respect strict des délais et normes de sécurité</li>
          <li>Accompagnement personnalisé de la conception à la livraison</li>
        </ul>
      `,
      image: "/images/about-us.jpg",
    }),
  },
})
</script>

<style scoped>
.prose ul {
  list-style: none;
  padding-left: 0;
}
.prose li {
  margin-bottom: 0.75rem;
  display: flex;
  align-items: center;
  font-weight: 500;
  color: #4b5563; /* text-gray-600 */
}
.prose li::before {
  content: "✓";
  color: #2563eb; /* text-blue-600 */
  font-weight: bold;
  margin-right: 0.75rem;
  flex-shrink: 0;
}

@keyframes fadeInLeft {
  from {
    opacity: 0;
    transform: translateX(-40px);
  }
  to {
    opacity: 1;
    transform: translateX(0);
  }
}
@keyframes fadeInRight {
  from {
    opacity: 0;
    transform: translateX(40px);
  }
  to {
    opacity: 1;
    transform: translateX(0);
  }
}
.animate-fadeInLeft {
  animation: fadeInLeft 1s ease-out forwards;
}
.animate-fadeInRight {
  animation: fadeInRight 1s ease-out forwards;
}
</style>
