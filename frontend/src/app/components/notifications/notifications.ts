import { Component } from '@angular/core';
import { CommonModule } from '@angular/common';
import { Notification, NotificationService } from '../../services/notification/notification';
import { NgForOf } from '@angular/common';

@Component({
  selector: 'app-notifications',
  standalone: true,
  imports: [CommonModule, NgForOf],
  templateUrl: './notifications.html' 
})
export class Notifications {
  notifications: Notification[] = [];

  constructor(private notifService: NotificationService) {
    this.notifService.notifications$.subscribe(n => this.notifications = n);
  }
}
