<script setup>
import { ref } from 'vue';
import { Inertia } from '@inertiajs/inertia';
import { Link, usePage } from '@inertiajs/vue3';
import DashboardLayout from '@/Layouts/AuthenticatedLayout.vue'


const props = defineProps({
    reservations: Object,
   filters: {
        type: Object,
        default: () => ({ search: '', status: '' })
    }
});

const changeStatus = (id, status) => {
    Inertia.post(route('reservations.updateStatus', id), { status });
};

const search = ref(props.filters.search || '');
const statusFilter = ref(props.filters.status || '');

const applyFilters = () => {
    Inertia.get(route('reservations.index'), { search: search.value, status: statusFilter.value }, { preserveState: true });
};
</script>

<template>
     <DashboardLayout>
<div class="p-6 bg-white shadow rounded-lg space-y-4">
    <div class="flex justify-between items-center">
        <h2 class="text-xl font-bold">Réservations</h2>
       <Link :href="route('reservations.create')" class="bg-blue-600 text-white px-4 py-2 rounded">
    Nouvelle Réservation
</Link>
    </div>

    <!-- Filtres -->
    <div class="flex gap-2">
        <input type="text" v-model="search" placeholder="Recherche..." class="border rounded px-3 py-2" />
        <select v-model="statusFilter" class="border rounded px-3 py-2">
            <option value="">Tous les statuts</option>
            <option value="pending">En attente</option>
            <option value="confirmed">Confirmée</option>
            <option value="cancelled">Annulée</option>
        </select>
        <button @click="applyFilters" class="bg-gray-600 text-white px-3 py-2 rounded">Filtrer</button>
    </div>

    <table class="min-w-full divide-y divide-gray-200">
        <thead class="bg-gray-50">
            <tr>
                <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase">Client</th>
                <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase">Service</th>
                <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase">Date d'arrivée</th>
                <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase">Date de départ</th>
                <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase">Statut</th>
                <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase">Actions</th>
            </tr>
        </thead>
        <tbody class="bg-white divide-y divide-gray-200">
            <tr v-for="reservation in reservations.data" :key="reservation.id">
                <td class="px-6 py-4">{{ reservation.name }}</td>
                <td class="px-6 py-4">{{ reservation.service.title }}</td>
                <td class="px-6 py-4">{{ reservation.check_in }}</td>
                <td class="px-6 py-4">{{ reservation.check_out }}</td>
                <td class="px-6 py-4">{{ reservation.status }}</td>
                <td class="px-6 py-4 space-x-2">
                    <button class="px-2 py-1 bg-green-500 text-white rounded"
                        @click="changeStatus(reservation.id, 'confirmed')">Confirmer</button>
                    <button class="px-2 py-1 bg-red-500 text-white rounded"
                        @click="changeStatus(reservation.id, 'cancelled')">Annuler</button>
                </td>
            </tr>
        </tbody>
    </table>

    <!-- Pagination -->
    <div class="mt-4">
        <Link
            v-if="reservations.prev_page_url"
            :href="reservations.prev_page_url"
            class="px-3 py-1 bg-gray-200 rounded"
        >
            Précédent
        </Link>
        <Link
            v-if="reservations.next_page_url"
            :href="reservations.next_page_url"
            class="px-3 py-1 bg-gray-200 rounded"
        >
            Suivant
        </Link>
    </div>
</div>
</DashboardLayout>
</template>
