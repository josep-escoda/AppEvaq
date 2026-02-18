import { Injectable, signal, computed } from '@angular/core';

@Injectable({ providedIn: 'root' })
export class Signal {
  private isLoggedSignal = signal<boolean>(this.checkAuthState());

  isLoggedIn = computed(() => this.isLoggedSignal());

  private checkAuthState(): boolean {
    const token = localStorage.getItem('token');
    return !!token && token.length > 0;
  }

  setLoggedIn(value: boolean) {
    this.isLoggedSignal.set(value);
  }
}
