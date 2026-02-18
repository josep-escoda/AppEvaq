// Imports d'Angular, routing i formularis
import { Component } from '@angular/core';
import { Router } from '@angular/router';
import { Auth } from '../../services/auth/auth';
import { CommonModule } from '@angular/common';
import { FormsModule } from '@angular/forms';

// Servei de senyals per indicar l'estat d'autenticació a l'aplicació
import { Signal } from '../../services/signals/signal';

@Component({
  selector: 'app-login',
  imports: [CommonModule, FormsModule],
  templateUrl: './login.html',
  styleUrl: './login.css',
})
export class Login {
  // Camps del formulari de login
  email: string = '';
  password: string = '';
  errorMissatge: string = '';

  // Control per mostrar/ocultar la contrasenya a la UI
  mostrarContrasenya: boolean = false;

  // Injecció de dependències: router per navegar, Auth per autenticació,
  // signal per notificar l'estat d'usuari a altres parts de l'app
  constructor(private router: Router, private AuthService: Auth, private signal: Signal) { }

  // Canviar l'estat de visibilitat de la contrasenya
  toggleContrasenya() {
    this.mostrarContrasenya = !this.mostrarContrasenya;
  }

  // Enviar formulari de login i processar la resposta
  login() {
    this.AuthService.login(this.email, this.password).subscribe({
      next: res => {
        // Si rebem token, desar-lo i marcar usuari com autenticat
        if (res.access_token) {
          localStorage.setItem('token', res.access_token);
          this.signal.setLoggedIn(true);
          this.router.navigate(['/home']);
        }
      },
      error: err => {
        // Registrar l'error a la consola per depuració
        console.error(err.error);
        if (err.status === 422) {
          // Validacions de formulari retornades per l'API
          const messages = Object.values(err.error.errors).flat();
          this.errorMissatge = messages.join(' ');
        } else {
          // Missatge genèric d'error de connexió
          this.errorMissatge = 'Error en la connexió al servidor. Torna-ho a intentar més tard.';
        }
      }
    });

  }
}
