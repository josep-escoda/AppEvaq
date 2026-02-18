import { Injectable, signal } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { Observable } from 'rxjs';
import { environment } from '../../../environments/environment';
import { Evacuation } from '../../models/evacuation/evacuation';

@Injectable({
  providedIn: 'root',
})
export class Evacuations {
  private apiUrl = environment.apiUrl;
  
  evacuationStarted = signal(false);
  constructor(private http: HttpClient) { }

  startEvacuation(): Observable<any> {
    return this.http.post<any>(`${this.apiUrl}/evacuations/start`, {});
  }

  stopEvacuation(): Observable<any> {
    return this.http.patch<any>(`${this.apiUrl}/evacuations/stop`, {});
  }

  getActiveEvacuation() {
    return this.http.get<any>(`${this.apiUrl}/evacuations/active`);
  }

  setEvacuationStarted(value: boolean) {
    this.evacuationStarted.set(value);
  }

  getEvacuations(): Observable<Evacuation[]> {
    return this.http.get<Evacuation[]>(`${this.apiUrl}/evacuations`);
  }
}
