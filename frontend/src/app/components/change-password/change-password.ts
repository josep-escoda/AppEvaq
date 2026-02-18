// Imports d'Angular i mòduls necessaris
import { Component } from '@angular/core';
import { CommonModule } from '@angular/common';
import { FormsModule } from '@angular/forms';

// Servei d'autenticació per canviar la contrasenya
import { Auth } from '../../services/auth/auth';

@Component({
  selector: 'app-change-password',
  standalone: true,
  imports: [FormsModule, CommonModule],
  templateUrl: './change-password.html',
  styleUrls: ['./change-password.css']
})
export class ChangePassword {
  // Camps del formulari
  currentPassword: string = '';        // contrasenya actual introduïda per l'usuari
  newPassword: string = '';            // nova contrasenya desitjada
  confirmNewPassword: string = '';     // confirmació de la nova contrasenya

  // Controls per mostrar/ocultar les contrasenyes a la UI
  mostrarContrasenya: boolean = false;
  mostrarConfirmContrasenya: boolean = false;

  // Missatges per retroacció a l'usuari
  errorMessage: string = '';
  successMessage: string = '';

  // Injecció del servei d'autenticació
  constructor(private auth: Auth) { }

  // Alterna la visibilitat de la contrasenya actual
  toggleContrasenya() {
    this.mostrarContrasenya = !this.mostrarContrasenya;
  }

  // Alterna la visibilitat del camp de confirmació
  toggleConfirmContrasenya() {
    this.mostrarConfirmContrasenya = !this.mostrarConfirmContrasenya;
  }

  // Enviar la sol·licitud de canvi de contrasenya
  changePassword() {
    // Validacions bàsiques abans de fer la crida al servei
    if (!this.currentPassword || !this.newPassword || !this.confirmNewPassword) {
      this.errorMessage = 'Si us plau, omple tots els camps';
      this.successMessage = '';
      return;
    }

    // Comprovar que la nova contrasenya i la confirmació coincideixin
    if (this.newPassword !== this.confirmNewPassword) {
      this.errorMessage = 'La nova contrasenya i la confirmació no coincideixen';
      this.successMessage = '';
      return;
    }

    // Cridar el servei d'autenticació per canviar la contrasenya
    this.auth.changePassword(this.currentPassword, this.newPassword, this.confirmNewPassword)
      .subscribe({
        next: res => {
          // En cas d'èxit, netejar els camps i mostrar missatge d'èxit
          this.successMessage = 'Contrasenya canviada correctament';
          this.errorMessage = '';
          this.currentPassword = '';
          this.newPassword = '';
          this.confirmNewPassword = '';
        },
        error: err => {
          // Mostrar l'error retornat per l'API o un missatge genèric
          this.errorMessage = err.error?.message || 'Error al canviar la contrasenya';
          this.successMessage = '';
        }
      });
  }
}
