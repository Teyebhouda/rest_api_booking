
<script setup>
import AuthenticatedLayout from '@/Layouts/AuthenticatedLayout.vue';
import { ref, watch } from 'vue';
import { Inertia } from '@inertiajs/inertia';
import { defineProps } from 'vue';
import { useForm } from '@inertiajs/vue3';
const props = defineProps({
  errors: Object,
  page: Object,
});
const form = useForm({
  title: props.page.title || '',
  slug: props.page.slug || '',
  content: props.page.content || '',
  meta_title: props.page.meta_title || '',
  meta_description: props.page.meta_description || '',
  meta_keywords: props.page.meta_keywords || ''
});
function submit() {
  form.put(route('pages.update', { pageId: props.page.id }), {
    onSuccess: () => Inertia.visit(route('pages')),
  });
}
</script>
<template>
  <AuthenticatedLayout>
    <template #header>
      <h2 class="font-semibold text-xl text-gray-800 leading-tight">
        Edit Page
      </h2>
    </template>

    <div class="py-12">
      <div class="max-w-7xl mx-auto sm:px-6 lg:px-8">
        <div class="bg-white overflow-hidden shadow-sm sm:rounded-lg p-6">
          <form @submit.prevent="submit">
            <!-- Title -->
            <div class="mb-4">
              <label for="title" class="block text-gray-700 font-bold mb-2">
                Title
              </label>
              <input
                v-model="form.title"
                type="text"
                id="title"
                name="title"
                class="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline"
              />
              <div v-if="errors.title" class="text-red-500 text-sm mt-1">
                {{ errors.title }}
              </div>
            </div>

            <!-- Slug -->
            <div class="mb-4">
              <label for="slug" class="block text-gray-700 font-bold mb-2">
                Slug
              </label>
              <input
                v-model="form.slug"
                type="text"
                id="slug"
                name="slug"
                class="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline"
              />
              <div v-if="errors.slug" class="text-red-500 text-sm mt-1">
                {{ errors.slug }}
              </div>
            </div>

            <!-- Content -->
            <div class="mb-4">
              <label for="content" class="block text-gray-700 font-bold mb-2">
                Content
              </label>

              <QuillEditor
                v-model:content="form.content"
                contentType="html"
                theme="snow"
                toolbar="full"
                class="bg-white rounded shadow h-[300px] resize-y overflow-auto"
              />
             
              <div v-if="errors.content" class="text-red-500 text-sm mt-1">
                {{ errors.content }}
              </div>
            </div>
            <!-- Meta Title -->
            <div class="mb-4">
              <label for="meta_title" class="block text-gray-700 font-bold mb-2">
                Meta Title
              </label>
              <input
                v-model="form.meta_title"
                type="text"
                id="meta_title"
                name="meta_title"
                class="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline"
              />
              <div v-if="errors.meta_title" class="text-red-500 text-sm mt-1">
                {{ errors.meta_title }}
              </div>
            </div>
            <!-- Meta Description -->
            <div class="mb-4">
              <label for="meta_description" class="block text-gray-700 font-bold mb-2">
                Meta Description
              </label>
              <input
                v-model="form.meta_description"
                type="text"
                id="meta_description"
                name="meta_description"
                class="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline"
              />
              <div v-if="errors.meta_description" class="text-red-500 text-sm mt-1">
                {{ errors.meta_description }}
              </div>
            </div>
            <!-- Meta Keywords -->
            <div class="mb-4">
              <label for="meta_keywords" class="block text-gray-700 font-bold mb-2">
                Meta Keywords
              </label>
              <input
                v-model="form.meta_keywords"
                type="text"
                id="meta_keywords"
                name="meta_keywords"
                class="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline"
              />
              <div v-if="errors.meta_keywords" class="text-red-500 text-sm mt-1">
                {{ errors.meta_keywords }}
              </div>
            </div>
            <!-- Buttons -->
            <div>
              <button
                type="submit"
                class="bg-blue-500 hover:bg-blue-700 text-white font-bold py-2 px-4 rounded focus:outline-none focus:shadow-outline"
              >
                Update Page
              </button>
              <button
                @click="$inertia.visit(route('pages'))"
                type="button"
                class="ml-4 bg-gray-500 hover:bg-gray-700 text-white font-bold py-2 px-4 rounded focus:outline-none focus:shadow-outline"
                >
                Cancel
              </button>
               


            </div>
            </form>
        </div>


        </div>    
      </div>
   
    </AuthenticatedLayout>
</template>