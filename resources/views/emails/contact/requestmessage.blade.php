@component('mail::message')
# Nouvelle demande de contact

**Nom :** {{ $data['nom'] }}  
**Email :** {{ $data['email'] }}  
**Téléphone :** {{ $data['telephone'] }}  

**Message :**

{{ $data['message'] }}

Merci,<br>
{{ config('app.name') }}
@endcomponent
