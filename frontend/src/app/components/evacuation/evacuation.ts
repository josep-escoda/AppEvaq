import { CommonModule } from '@angular/common';
import { Component, OnInit } from '@angular/core';
import { Evacuations } from '../../services/evacuations/evacuations';
import { Evacuation } from '../../models/evacuation/evacuation';


@Component({
  selector: 'app-evacuation',
  imports: [CommonModule],
  templateUrl: './evacuation.html',
  styleUrl: './evacuation.css',
})
export class EvacuationComponent implements OnInit{
 evacuations: Evacuation[] = [];
  loading: boolean = true;

  constructor(private evacuationService: Evacuations) { }

  ngOnInit(): void {
    this.loadEvacuations();
  }

  loadEvacuations(): void {
    this.loading = true;
    this.evacuationService.getEvacuations().subscribe({
      next: (data) => {
        this.evacuations = data.sort((a, b) => 
          new Date(b.started_at).getTime() - new Date(a.started_at).getTime()
        );
        this.loading = false;
      },
      error: (err) => {
        console.error('Error al carregar evacuacions:', err);
        this.loading = false;
      }
    });
  }

  formatDate(date: string): string {
    return new Date(date).toLocaleString('ca-ES', {
      day: '2-digit',
      month: '2-digit',
      year: 'numeric',
      hour: '2-digit',
      minute: '2-digit'
    });
  }

  getDuration(startedAt: string, endedAt: string | null): string {
    const start = new Date(startedAt);
    const end = endedAt ? new Date(endedAt) : new Date();
    const diff = end.getTime() - start.getTime();
    
    const hours = Math.floor(diff / (1000 * 60 * 60));
    const minutes = Math.floor((diff % (1000 * 60 * 60)) / (1000 * 60));
    
    if (hours > 0) {
      return `${hours}h ${minutes}m`;
    }
    return `${minutes}m`;
  }
}
