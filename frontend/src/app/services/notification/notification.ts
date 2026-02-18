import { Injectable } from '@angular/core';
import { BehaviorSubject } from 'rxjs';

export type NotificationType = 'success' | 'info' | 'error';

export interface Notification {
  message: string;
  type: NotificationType;
  duration?: number; 
}

@Injectable({ providedIn: 'root' })
export class NotificationService {
  private _notifications = new BehaviorSubject<Notification[]>([]);
  notifications$ = this._notifications.asObservable();

  show(message: string, type: NotificationType = 'info', duration = 3000) {
    const current = this._notifications.value;
    const notification: Notification = { message, type, duration };
    this._notifications.next([...current, notification]);

    setTimeout(() => {
      this._notifications.next(this._notifications.value.filter(n => n !== notification));
    }, duration);
  }

  success(message: string, duration?: number) {
    this.show(message, 'success', duration);
  }

  info(message: string, duration?: number) {
    this.show(message, 'info', duration);
  }

  error(message: string, duration?: number) {
    this.show(message, 'error', duration);
  }
}
