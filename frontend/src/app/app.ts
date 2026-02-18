import { Component, signal, OnInit } from '@angular/core';
import { RouterOutlet } from '@angular/router';
import { RouterModule } from '@angular/router';
import { Notifications } from './components/notifications/notifications';
import { Router } from '@angular/router';
import { CommonModule } from '@angular/common';
import { Signal } from './services/signals/signal';
import { Evacuations } from './services/evacuations/evacuations';

@Component({
  selector: 'app-root',
  imports: [RouterOutlet, Notifications, RouterModule, CommonModule],
  templateUrl: './app.html',
  styleUrl: './app.css'
})

export class App implements OnInit {

  mobileMenuOpen = false;

  ngOnInit() {
    this.refreshEvacuationState();
  }

  protected readonly title = signal('evacuacio-institut-F');

  mostrarZones = false;
  constructor(private router: Router, public signal: Signal, public evacuations: Evacuations) { }

  logout() {
    localStorage.removeItem("token");
    this.signal.setLoggedIn(false);
    this.router.navigate(['/login']);
  }


  refreshEvacuationState() {
    this.evacuations.getActiveEvacuation().subscribe({
      next: (evacuation) => {
        const isActive = evacuation && evacuation.active === true;
        this.evacuations.setEvacuationStarted(isActive);
      },
      error: () => {
        console.warn('Error obtenint el estat de la evacuació');
        this.evacuations.setEvacuationStarted(false);
      }
    });
  }


  toggleEvacuacio() {
    const action$ = this.evacuations.evacuationStarted()
      ? this.evacuations.stopEvacuation()
      : this.evacuations.startEvacuation();

    action$.subscribe({
      next: () => {
        console.log('Estat de la evacuació actualizat');
        this.refreshEvacuationState();
      },
      error: (err) => {
        console.error('Error modificant el estat de la evacuació', err);
      }
    });
  }

}
