// Imports d'Angular, routing i formularis
import { Component } from '@angular/core';
import { RouterModule } from '@angular/router';
import { Router } from '@angular/router';
import { Auth } from '../../services/auth/auth';
import { CommonModule } from '@angular/common';
import { FormsModule } from '@angular/forms';

// Servei de senyals per compartir estat d'autenticació a l'aplicació
import { Signal } from '../../services/signals/signal';

@Component({
  selector: 'app-register',
  imports: [CommonModule, FormsModule, RouterModule],
  templateUrl: './register.html',
  styleUrl: './register.css',
})
export class Register {
  // Camps del formulari de registre
  name: string = '';
  email: string = '';
  password: string = '';

  // Control per mostrar/ocultar la contrasenya
  mostrarContrasenya: boolean = false;

  // Missatge d'error per mostrar a l'usuari
  errorMissatge: string = '';

  // Injecció de dependències: router per navegar, auth per cridar API d'autenticació,
  // signal per notificar canvis d'estat d'usuari
  constructor(private router: Router, private auth: Auth, private signal: Signal) { }

  // Alternar visibilitat de la contrasenya al formulari
  toggleContrasenya() {
    this.mostrarContrasenya = !this.mostrarContrasenya;
  }

  // Enviar la petició de registre i processar la resposta
  register() {
    // Reset del missatge d'error abans de la crida
    this.errorMissatge = '';

    this.auth.register(this.name, this.email, this.password).subscribe({
      next: res => {
        // Si l'API retorna un token, desar-lo i marcar l'usuari com autenticat
        if (res.access_token) {
          localStorage.setItem('token', res.access_token);
          this.signal.setLoggedIn(true);
          this.router.navigate(['/home']);
        }
      },
      error: err => {
        // Registrar l'error i processar errors de validació (422) o errors generals
        console.error(err.error);
        if (err.status === 422) {
          const messages = Object.values(err.error.errors).flat();
          this.errorMissatge = messages.join(' ');
        } else {
          this.errorMissatge = 'Error en la connexió al servidor. Torna-ho a intentar més tard.';
        }
      }
    });
  }
}
