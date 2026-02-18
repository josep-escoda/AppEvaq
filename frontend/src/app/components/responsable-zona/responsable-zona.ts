// Imports d'Angular, enrutament i utilitats RxJS
import { Component, OnInit, OnDestroy } from '@angular/core';
import { CommonModule } from '@angular/common';
import { FormsModule } from '@angular/forms';
import { ActivatedRoute, Router } from '@angular/router';
import { Subject, takeUntil, filter } from 'rxjs';

// Components i serveis del projecte
import { Home } from '../home/home';
import { SpacesService } from '../../services/spaces/spaces';
import { NotificationService } from '../../services/notification/notification';
import { Evacuations } from '../../services/evacuations/evacuations';

// Models utilitzats pel component
import { SpaceDisplay } from '../../models/SpaceDisplay/space-display';
import { Punt } from '../../models/punt/punt';
import { Space } from '../../models/space/space';

@Component({
  selector: 'app-responsable-zona',
  standalone: true,
  imports: [Home, CommonModule, FormsModule],
  templateUrl: './responsable-zona.html',
  styleUrl: './responsable-zona.css',
})
export class ResponsableZona implements OnInit, OnDestroy {
  // Subject per cancel·lar subscripcions quan el component es destrueix
  private destroy$ = new Subject<void>();

  // Espais visibles a la planta actual (amb colorització)
  spacesPlantaActual: SpaceDisplay[] = [];
  plantaSeleccionada = -1; // planta seleccionada per l'usuari

  // Informació del responsable i la zona
  responsableName: string = '';
  zoneId!: number;
  zoneName: string = 'Carregant...';
  isLoading = true; // indicador de càrrega inicial

  constructor(
    private spacesService: SpacesService,
    private notif: NotificationService,
    private evacuationsService: Evacuations,
    private route: ActivatedRoute,
    private router: Router
  ) { }

  ngOnInit(): void {
    // Llegir paràmetres de la URL (nom del responsable i id de la zona)
    this.route.queryParams.pipe(takeUntil(this.destroy$)).subscribe(params => {
      this.responsableName = params['name'];
      this.zoneId = +params['zoneId'];

      // Validar paràmetres mínims; si són invàlids, redirigir a login
      if (!this.responsableName || !this.zoneId) {
        //        this.notif.error('Paràmetres invàlids');
        this.router.navigate(['/login']);
        return;
      }

      // Esperar que el servei de zones estigui carregat i obtenir el nom de la zona
      this.spacesService.zones$
        .pipe(
          takeUntil(this.destroy$),
          filter(zones => zones.length > 0)
        )
        .subscribe(zones => {
          const zone = zones.find(z => z.id === this.zoneId);
          this.zoneName = zone?.name || `Zona ${this.zoneId}`;
          this.isLoading = false;
        });

      // Registrar el responsable i carregar espais de la planta inicial
      this.registrarResponsable();
      this.carregarSpacesPerPlanta(this.plantaSeleccionada);
    });
  }

  ngOnDestroy(): void {
    // Cancel·lar qualsevol subscripció oberta
    this.destroy$.next();
    this.destroy$.complete();
  }

  // ========== REGISTRE DEL RESPONSABLE ==========

  private registrarResponsable(): void {
    // Enviar dades al servei per registrar el responsable de la zona (si no existeix)
    const data = {
      zone_id: this.zoneId,
      name: this.responsableName,
      email: null
    };

    this.spacesService.registerResponsable(data)
      .pipe(takeUntil(this.destroy$))
      .subscribe({
        error: (error) => {
          if (error.status !== 409) {
            this.router.navigate(['/login']);
          }
        }
      });
  }

  // ========== GESTIÓ DE PLANTES ==========

  private carregarSpacesPerPlanta(planta: number): void {
    // Carregar els espais corresponents a la planta i zona seleccionada
    this.spacesService.getSpacesByFloorAndZone(planta, this.zoneId)
      .pipe(takeUntil(this.destroy$))
      .subscribe({
        next: (spaces) => {
          this.spacesPlantaActual = this.mapSpacesWithColorsByStatus(spaces);
        },
        error: (error) => {
          this.notif.error('Error al carregar els espais');
        }
      });
  }

  onPlantaSeleccionada(plantaNumero: number): void {
    // Quan l'usuari selecciona una planta, actualitzar la vista
    this.plantaSeleccionada = plantaNumero;
    this.carregarSpacesPerPlanta(plantaNumero);
  }

  private mapSpacesWithColorsByStatus(spaces: Space[]): SpaceDisplay[] {
    return spaces.map(space => ({
      ...space,
      color: this.spacesService.getColorPerEstat(space.status),
      floor: space.floor ?? this.plantaSeleccionada
    }));
  }

  // ========== CANVI D'ESTAT DE VERIFICACIÓ ==========

  onSpaceStatusToggle(space: SpaceDisplay): void {
    if (!space.id) {
      this.notif.error('Espai invàlid');
      return;
    }

    // Comprovar si hi ha una evacuació activa abans de permetre el canvi d'estat
    this.evacuationsService.getActiveEvacuation()
      .pipe(takeUntil(this.destroy$))
      .subscribe({
        next: (activeEvacuation) => {
          // Si hi ha una evacuació activa, permetre el canvi d'estat
          if (activeEvacuation && activeEvacuation.id) {
            this.canviarEstatEspai(space);
          } else {
            // Si NO hi ha evacuació activa, no permetre el canvi
            this.router.navigate(['/login']);
            // this.notif.error('Només es pot canviar l\'estat durant una evacuació activa');
          }
        },
        error: (error) => {
          // Si l'error és 404 (no hi ha evacuació activa), no permetre el canvi
          if (error.status === 404) {
            this.router.navigate(['/login']);
            //this.notif.error('Només es pot canviar l\'estat durant una evacuació activa');
          } else {
            this.notif.error('Error al verificar l\'estat d\'evacuació');
          }
        }
      });
  }

  private canviarEstatEspai(space: SpaceDisplay): void {
    // Alternar entre 'verified' i 'unverified'
    const nouEstat = space.status === 'verified' ? 'unverified' : 'verified';

    // Enviar la crida per actualitzar l'estat de l'espai i reflectir el canvi a la UI
    this.spacesService.updateSpaceStatus(space.id!, nouEstat)
      .pipe(takeUntil(this.destroy$))
      .subscribe({
        next: (spaceActualitzat) => {
          const index = this.spacesPlantaActual.findIndex(s => s.id === space.id);
          if (index !== -1) {
            this.spacesPlantaActual[index] = {
              ...spaceActualitzat,
              color: this.spacesService.getColorPerEstat(spaceActualitzat.status),
              floor: spaceActualitzat.floor ?? this.plantaSeleccionada
            };
          }

          const missatge = nouEstat === 'verified'
            ? `${space.name} verificat correctament`
            : `${space.name} marcat com a no verificat`;
          this.notif.success(missatge);
        },
        error: (error) => {
          this.notif.error('Error al canviar l\'estat de l\'espai');
        }
      });
  }

  // ========== ESTADÍSTIQUES ==========

  get totalSpaces(): number {
    return this.spacesPlantaActual.length;
  }

  get spacesVerificats(): number {
    return this.spacesPlantaActual.filter(s => s.status === 'verified').length;
  }

  get spacesNoVerificats(): number {
    return this.spacesPlantaActual.filter(s => s.status === 'unverified').length;
  }

  get percentatgeVerificat(): number {
    if (this.totalSpaces === 0) return 0;
    return Math.round((this.spacesVerificats / this.totalSpaces) * 100);
  }

  onSvgClick(punt: Punt): void {
  }
}