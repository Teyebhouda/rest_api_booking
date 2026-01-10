<?php

namespace App\Mail;

use Illuminate\Bus\Queueable;
use Illuminate\Mail\Mailable;
use Illuminate\Queue\SerializesModels;

class DevisRequestMail extends Mailable
{
    use Queueable, SerializesModels;

    public $data; // les données du formulaire

    public function __construct($data)
    {
        $this->data = $data;
    }

    public function build()
    {
        return $this->subject('Nouvelle demande de devis')
                    ->markdown('emails.contact.request');
    }

    
}
