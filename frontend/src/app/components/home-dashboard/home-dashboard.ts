// Imports d'Angular i utilitats RxJS
import { Component, OnInit, OnDestroy } from '@angular/core';
import { CommonModule } from '@angular/common';
import { FormsModule } from '@angular/forms';
import { Subject, interval, takeUntil, switchMap, startWith } from 'rxjs';

// Components i serveis reutilitzats
import { Home } from '../home/home';
import { SpacesService } from '../../services/spaces/spaces';
import { NotificationService } from '../../services/notification/notification';

// Models de dades
import { SpaceDisplay } from '../../models/SpaceDisplay/space-display';
import { Space } from '../../models/space/space';

@Component({
  selector: 'app-home-dashboard',
  standalone: true,
  imports: [Home, CommonModule, FormsModule],
  templateUrl: './home-dashboard.html',
  styleUrl: './home-dashboard.css',
})
export class HomeDashboard implements OnInit, OnDestroy {
  // Subject per cancel·lar subscripcions quan el component es destrueix
  private destroy$ = new Subject<void>();

  // Interval en ms per actualitzar la vista (polling)
  private readonly REFRESH_INTERVAL = 5000;

  // Estat visible del component
  spacesPlantaActual: SpaceDisplay[] = []; // espais de la planta actual amb colors
  plantaSeleccionada = -1;                  // planta seleccionada 
  isLoading = false;                        // indicador de càrrega
  
  constructor(
    private spacesService: SpacesService,
    private notif: NotificationService
  ) {}

  ngOnInit(): void {
    // Iniciar el procés d'actualització periòdica dels espais
    this.iniciarRefrescAutomàtic();
  }

  ngOnDestroy(): void {
    this.destroy$.next();
    this.destroy$.complete();
  }


  private iniciarRefrescAutomàtic(): void {
    interval(this.REFRESH_INTERVAL)
      .pipe(
        startWith(0), 
        switchMap(() => this.spacesService.getSpacesByFloor(this.plantaSeleccionada)),
        takeUntil(this.destroy$)
      )
      .subscribe({
        next: (spaces) => {
          // Mapear espais per adjuntar color segons l'estat i actualitzar UI
          this.spacesPlantaActual = this.mapSpacesWithColorsByStatus(spaces);
          this.isLoading = false;
        },
        error: (error) => {
          // Registrar i notificar l'error a l'usuari
          console.error('Error carregant spaces per planta:', error);
          this.notif.error('Error al carregar els espais');
          this.isLoading = false;
        }
      });
  }


  private carregarSpacesPerPlanta(planta: number): void {
    this.isLoading = true;
    // Carregar espais per una planta específica (crida puntual)
    this.spacesService.getSpacesByFloor(planta)
      .pipe(takeUntil(this.destroy$))
      .subscribe({
        next: (spaces) => {
          this.spacesPlantaActual = this.mapSpacesWithColorsByStatus(spaces);
          this.isLoading = false;
        },
        error: (error) => {
          console.error('Error carregant spaces per planta:', error);
          this.notif.error('Error al carregar els espais');
          this.isLoading = false;
        }
      });
  }

  onPlantaSeleccionada(plantaNumero: number): void {
    // Quan l'usuari selecciona una planta, reiniciar el polling i començar de nou
    this.plantaSeleccionada = plantaNumero;
    this.destroy$.next();
    this.destroy$ = new Subject<void>();
    this.iniciarRefrescAutomàtic();
  }

  private mapSpacesWithColorsByStatus(spaces: Space[]): SpaceDisplay[] {
    return spaces.map(space => ({
      ...space,
      color: this.spacesService.getColorPerEstat(space.status),
      floor: space.floor ?? this.plantaSeleccionada
    }));
  }

  // ========== ESTADÍSTIQUES ==========
  get totalSpaces(): number {
    // Nombre total d'espais a la vista actual
    return this.spacesPlantaActual.length;
  }

  get spacesVerificats(): number {
    // Comptar espais amb estat 'verified'
    return this.spacesPlantaActual.filter(s => s.status === 'verified').length;
  }

  get spacesNoVerificats(): number {
    // Comptar espais amb estat 'unverified'
    return this.spacesPlantaActual.filter(s => s.status === 'unverified').length;
  }

  get percentatgeVerificat(): number {
    // Percentatge d'espais verificats (arrodonit)
    if (this.totalSpaces === 0) return 0;
    return Math.round((this.spacesVerificats / this.totalSpaces) * 100);
  }
  
}