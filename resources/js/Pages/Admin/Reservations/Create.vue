<script setup>
import { ref } from 'vue';
import { Inertia } from '@inertiajs/inertia';

const props = defineProps({
    services: Array
});

// Champs du formulaire
const form = ref({
    service_id: '',
    name: '',
    email: '',
    phone: '',
     check_in: '',
     check_out: '',
    note: ''
});

// Validation errors
const errors = ref({});

const submitForm = () => {
    Inertia.post(route('reservations.store'), form.value, {
        onError: (err) => {
            errors.value = err;
        },
        onSuccess: () => {
            form.value = {
                service_id: '',
                name: '',
                email: '',
                phone: '',
                check_in: '',
                check_out: '',
                note: ''
            };
            errors.value = {};
        }
    });
};
</script>

<template>
<div class="max-w-4xl mx-auto p-6 bg-white shadow rounded-lg">
    <h2 class="text-xl font-bold mb-4">Créer une réservation</h2>
    <form @submit.prevent="submitForm" class="space-y-4">

        <div>
            <label class="block font-medium text-gray-700">Service</label>
            <select v-model="form.service_id" class="mt-1 block w-full border rounded px-3 py-2">
                <option value="">-- Choisir un service --</option>
                <option v-for="service in services" :key="service.id" :value="service.id">
                    {{ service.title }}
                </option>
            </select>
            <span class="text-red-500 text-sm" v-if="errors.service_id">{{ errors.service_id[0] }}</span>
        </div>

        <div>
            <label class="block font-medium text-gray-700">Nom</label>
            <input type="text" v-model="form.name" class="mt-1 block w-full border rounded px-3 py-2" />
            <span class="text-red-500 text-sm" v-if="errors.name">{{ errors.name[0] }}</span>
        </div>

        <div>
            <label class="block font-medium text-gray-700">Email</label>
            <input type="email" v-model="form.email" class="mt-1 block w-full border rounded px-3 py-2" />
            <span class="text-red-500 text-sm" v-if="errors.email">{{ errors.email[0] }}</span>
        </div>

        <div>
            <label class="block font-medium text-gray-700">Téléphone</label>
            <input type="text" v-model="form.phone" class="mt-1 block w-full border rounded px-3 py-2" />
            <span class="text-red-500 text-sm" v-if="errors.phone">{{ errors.phone[0] }}</span>
        </div>

        <div>
            <label class="block font-medium text-gray-700">Date & Heure d'arrivée</label>
            <input type="datetime-local" v-model="form.check_in" class="mt-1 block w-full border rounded px-3 py-2" />
            <span class="text-red-500 text-sm" v-if="errors.check_in">{{ errors.check_in[0] }}</span>
        </div>

        <div>
            <label class="block font-medium text-gray-700">Date & Heure de départ</label>
            <input type="datetime-local" v-model="form.check_out" class="mt-1 block w-full border rounded px-3 py-2" />
            <span class="text-red-500 text-sm" v-if="errors.check_out">{{ errors.check_out[0] }}</span>
        </div>

        <div>
            <label class="block font-medium text-gray-700">Note</label>
            <textarea v-model="form.note" class="mt-1 block w-full border rounded px-3 py-2"></textarea>
            <span class="text-red-500 text-sm" v-if="errors.note">{{ errors.note[0] }}</span>
        </div>

        <button type="submit" class="bg-blue-600 text-white px-4 py-2 rounded">
            Créer la réservation
        </button>
    </form>
</div>
</template>
