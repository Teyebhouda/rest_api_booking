@component('mail::message')
# Nouvelle demande de devis

**Nom :** {{ $data['nom'] }}  
**Email :** {{ $data['email'] }}  
**Téléphone :** {{ $data['telephone'] }}  
**Service souhaité :** {{ $data['service'] }}  

**Message :**

{{ $data['message'] }}

Merci,<br>
{{ config('app.name') }}
@endcomponent
