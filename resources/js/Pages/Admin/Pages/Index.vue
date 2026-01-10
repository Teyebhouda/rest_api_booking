<script setup>
import AuthenticatedLayout from '@/Layouts/AuthenticatedLayout.vue';

import { Inertia } from '@inertiajs/inertia';
const props = defineProps({
  pages: Array,
}); 
function deletePage(id) {
  if (confirm('Are you sure you want to delete this page?')) {
    Inertia.delete(route('pages.destroy', id));
  }
}


</script>

<template>
  <AuthenticatedLayout>
    <template #header>
      <h2 class="font-semibold text-xl text-gray-800 leading-tight">
        Pages
      </h2>
    </template>

    <div class="py-12">
       
          <div class="mx-auto max-w-7xl sm:px-6 lg:px-8">
 <button
            @click="Inertia.get(route('pages.create'))"
            class="mb-4 inline-flex items-center px-4 py-2 bg-blue-600 border border-transparent rounded-md font-semibold text-xs text-white uppercase tracking-widest hover:bg-blue-700 focus:outline-none focus:ring-2 focus:ring-blue-500 focus:ring-offset-2 transition ease-in-out duration-150"
        >
            Create New Page 
        </button>
        <div class="overflow-hidden bg-white shadow-sm sm:rounded-lg">

          <div class="p-6 bg-white border-b border-gray-200">

            <table class="min-w-full divide-y divide-gray-200">
              <thead class="bg-gray-50">
                <tr>
                  <th
                    scope="col"
                    class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider"
                  >
                    Title
                  </th>
                  <th
                    scope="col"
                    class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider"
                  >
                    Slug
                  </th>
                  <th scope="col" class="relative px-6 py-3">
                    <span class="sr-only">Edit</span>
                  </th>
                </tr>
              </thead>
              <tbody class="bg-white divide-y divide-gray-200">
                <tr v-for="page in pages" :key="page.id">
                  <td class="px-6 py-4 whitespace-nowrap text-sm font-medium text-gray-900">
                    {{ page.title }}
                  </td>
                  <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-500">
                    {{ page.slug }}
                  </td>
                  <td class="px-6 py-4 whitespace-nowrap text-right text-sm font-medium">
                    <a
                      :href="route('pages.edit', page.id)"
                      class="text-indigo-600 hover:text-indigo-900 mr-4"
                    >
                      Edit
                    </a>
                    <button
                      @click="deletePage(page.id)"
                      class="text-red-600 hover:text-red-900"
                    >
                      Delete
                    </button>
                  </td>
                  
                </tr>
              </tbody>
            </table>
          </div>
        </div>
      </div>
    </div>
  </AuthenticatedLayout>    
</template>