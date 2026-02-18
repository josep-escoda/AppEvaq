import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { Observable, BehaviorSubject } from 'rxjs';
import { Zone } from '../../models/zone/zone';
import { Space } from '../../models/space/space';
import { environment } from '../../../environments/environment';

export interface SpaceWithZone extends Space {
  zoneName?: string;
  plantaNumero?: number;
}

@Injectable({
  providedIn: 'root'
})
export class SpacesService {
  private baseUrl = environment.apiUrl;

  private zonesSubject = new BehaviorSubject<Zone[]>([]);
  public zones$ = this.zonesSubject.asObservable();

  private spacesSubject = new BehaviorSubject<Space[]>([]);
  public spaces$ = this.spacesSubject.asObservable();

  constructor(private http: HttpClient) {
    this.carregarZones();
  }

  // ========== ZONES ==========

  carregarZones(): void {
    this.http.get<Zone[]>(`${this.baseUrl}/zones`).subscribe({
      next: (zones) => this.zonesSubject.next(zones),
      error: (error) => console.error('Error carregant zones:', error)
    });
  }

  getZoneName(zoneId: number): string | undefined {
    const zone = this.zonesSubject.value.find(z => z.id === zoneId);
    return zone?.name;
  }

  // ========== SPACES CRUD ==========

  getSpacesByFloor(floor: number): Observable<Space[]> {
    return this.http.get<Space[]>(`${this.baseUrl}/spaces/by-floor`, {
      params: { floor }
    });
  }

  crearSpace(space: Omit<Space, 'id' | 'created_at' | 'updated_at'>): Observable<Space> {
    return this.http.post<Space>(`${this.baseUrl}/spaces`, space);
  }

  actualitzarSpace(id: number, space: Partial<Space>): Observable<Space> {
    return this.http.put<Space>(`${this.baseUrl}/spaces/${id}`, space);
  }

  eliminarSpace(id: number): Observable<void> {
    return this.http.delete<void>(`${this.baseUrl}/spaces/${id}`);
  }

  getSpacesByFloorAndZone(floor: number, zoneId: number): Observable<Space[]> {
    return this.http.get<Space[]>(`${this.baseUrl}/spaces/by-floor-zone`, {
      params: { floor, zone_id: zoneId }
    });
  }

  private colorsFixosZones = [
    '#3b82f6', 
    '#f59e0b', 
    '#8b5cf6', 
    '#ec4899', 
    '#84cc16', 
    '#a0522d', 
    '#06b6d4', 
    '#9ca3af',  
    '#14b8a6', 
    '#f97316', 
  ];

  getColorPerZona(zoneId: number): string {
    const zones = this.zonesSubject.value;
    const zoneIndex = zones.findIndex(z => z.id === zoneId);

    if (zoneIndex !== -1 && zoneIndex < this.colorsFixosZones.length) {
      return this.colorsFixosZones[zoneIndex];
    }

    return this.generarColorPerIndex(zoneIndex);
  }

  private generarColorPerIndex(index: number): string {
    const hue = (index * 137.508) % 360;
    return `hsl(${hue}, 70%, 55%)`;
  }

  getColorPerEstat(status: 'verified' | 'unverified'): string {
    return status === 'verified' ? '#10b981' : '#ef4444';
  }

  updateSpaceStatus(spaceId: number, status: 'verified' | 'unverified'): Observable<Space> {
    return this.http.patch<Space>(`${this.baseUrl}/spaces/${spaceId}/status`, { status });
  }

  registerResponsable(data: { zone_id: number; name: string; email?: string | null }): Observable<any> {
    return this.http.post(`${this.baseUrl}/evacuation-responsibles`, data);
  }

  updateSpaceStatusLocally(spaceId: number, newStatus: 'verified' | 'unverified'): void {
    const currentSpaces = this.spacesSubject.value;
    const updatedSpaces = currentSpaces.map(space =>
      space.id === spaceId
        ? { ...space, status: newStatus }
        : space
    );
    this.spacesSubject.next(updatedSpaces);
  }

  setSpaces(spaces: Space[]): void {
    this.spacesSubject.next(spaces);
  }
}