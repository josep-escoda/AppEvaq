import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { Observable } from 'rxjs';
import { environment } from '../../../environments/environment';

@Injectable({
  providedIn: 'root',
})
export class Auth {
  private apiUrl = environment.apiUrl;
  
  constructor(private http: HttpClient) { }
  login(email: string, password: string): Observable<any> {
    return this.http.post<any>(`${this.apiUrl}/login`, { email, password });
  }

  register(name: string, email: string, password: string): Observable<any> {
    return this.http.post<any>(`${this.apiUrl}/register`, { name, email, password });
  }

  changePassword(current: string, newP: string, confirm: string): Observable<any> {
    const token = localStorage.getItem('token');
    return this.http.post<any>(
      `${this.apiUrl}/change-password`,
      {
        current_password: current,
        new_password: newP,
        new_password_confirmation: confirm
      },
      {
        headers: {
          Authorization: `Bearer ${token}`
        }
      }
    );
  }


}
