<script setup>
import AuthenticatedLayout from '@/Layouts/AuthenticatedLayout.vue';
import { ref, watch } from 'vue';
import { Inertia } from '@inertiajs/inertia';
import { defineProps } from 'vue';
import { useForm } from '@inertiajs/vue3';

const props = defineProps({
  errors: Object,
});

const form = useForm({
  title: '',
  slug: '',
  content: '',
  meta_title: '',
  meta_description: '',
  meta_keywords: ''
});

function generateSlug(title) {
  return title
    .toLowerCase()
    .trim()
    .replace(/[^a-z0-9]+/g, '-')
    .replace(/^-+|-+$/g, '');
}

// Auto-generate slug from title
watch(() => form.title, (newTitle) => {
  form.slug = generateSlug(newTitle);
});

function submit() {
  form.post(route('pages.store'), {
    onSuccess: () => Inertia.visit(route('pages')),
  });
}
</script>

<template>
  <AuthenticatedLayout>
    <template #header>
      <h2 class="font-semibold text-xl text-gray-800 leading-tight">
        Create New Page
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
                required
              />
              <span v-if="props.errors.title" class="text-red-500 text-sm">{{ props.errors.title }}</span>
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
                required
              />
              <span v-if="props.errors.slug" class="text-red-500 text-sm">{{ props.errors.slug }}</span>
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

              <span v-if="props.errors.content" class="text-red-500 text-sm">{{ props.errors.content }}</span>
         
        
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
              <span v-if="props.errors.meta_title" class="text-red-500 text-sm">{{ props.errors.meta_title }}</span>

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
              <span v-if="props.errors.meta_description" class="text-red-500 text-sm">{{ props.errors.meta_description }}</span>
            </div>
            <!-- Meta Keywords -->
            <div class="mb-4">
              <label for="meta_keywords" class="block text-gray-700 font-bold mb-2">
                Meta Keywords (comma separated)
              </label>
              <input
                v-model="form.meta_keywords"
                type="text"
                id="meta_keywords"
                name="meta_keywords"
                class="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline"
              />
              <span v-if="props.errors.meta_keywords" class="text-red-500 text-sm">{{ props.errors.meta_keywords }}</span>
            </div>
            
            <!-- Buttons -->
            <div class="flex items-center justify-between">
              <button
                type="submit"
                class="bg-blue-500 hover:bg-blue-700 text-white font-bold py-2 px-4 rounded focus:outline-none focus:shadow-outline"
              >
                Create Page
              </button>
              <inertia-link
                :href="route('pages')"
                class="inline-block align-baseline font-bold text-sm text-blue-500 hover:text-blue-800"
              >
                Cancel
              </inertia-link>
            </div>
          </form>
        </div>
      </div>
    </div>
  </AuthenticatedLayout>
</template>
