<script setup>
import { toRefs, reactive } from 'vue'

const props = defineProps({
  form: {
    type: Object,
    required: true
  }
})

const { form } = toRefs(props)
// Initialiser le formulaire si nécessaire
if (!form.value.title) {
  form.value.title = ''
  form.value.subtitle = ''
  form.value.long_description = ''




}

</script>
<template>
  <form class="space-y-6">
     <div  class="border rounded-lg mb-4 bg-white shadow-md">
         <div  class="p-4 space-y-4">
             <label class="block font-semibold mb-1">Titre</label>
            <input v-model="form.title" type="text" placeholder="Titre" class="input mt-1" />
          <div>
     <div>
        <label class="block font-semibold mb-1">Texte d’introduction</label>
      <textarea v-model="form.subtitle" rows="4" class="block w-full border rounded p-2"></textarea>
    </div>

            <!-- ✅ Description longue en HTML -->
            <div>
              <label class="block font-semibold mb-1">Description longue (HTML)</label>
              <QuillEditor
                v-model:content="form.long_description"
                contentType="html"
                theme="snow"
                class="bg-white rounded shadow h-[150px] resize-y overflow-auto"
              />
            </div>
            </div>

          

         </div>

    
     </div>
  </form>
</template> 
