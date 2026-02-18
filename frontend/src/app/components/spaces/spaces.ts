// Imports d'Angular i utilitats RxJS
import { Component, OnInit, OnDestroy } from '@angular/core';
import { CommonModule } from '@angular/common';
import { FormsModule } from '@angular/forms';
import { Subject, takeUntil } from 'rxjs';

// Components i serveis del projecte
import { Home } from '../home/home';
import { SpacesService } from '../../services/spaces/spaces';
import { NotificationService } from '../../services/notification/notification';

// Models utilitzats per al component
import { SpaceDisplay } from '../../models/SpaceDisplay/space-display';
import { Punt } from '../../models/punt/punt';
import { Zone } from '../../models/zone/zone';
import { Space } from '../../models/space/space';

// Tipus per als diferents modes d'edició del component
type ModeEditor = 'none' | 'create' | 'edit' | 'delete';

@Component({
  selector: 'app-spaces',
  standalone: true,
  imports: [Home, CommonModule, FormsModule],
  templateUrl: './spaces.html',
  styleUrl: './spaces.css',
})
export class Spaces implements OnInit, OnDestroy {
  // Subject per cancel·lar subscripcions quan el component es destrueix
  private destroy$ = new Subject<void>();

  // Estat del component
  spacesPlantaActual: SpaceDisplay[] = []; // espais de la planta actual amb colorització
  zones: Zone[] = [];                       // llistat de zones disponibles
  modeEditor: ModeEditor = 'none';         // mode d'edició actual
  puntsTemporals: Punt[] = [];              // punts temporals mentre es crea/edita un espai
  spaceEditant: Space | null = null;        // espai que s'està editant (si n'hi ha)

  // Camps per crear/editar un espai
  nomNouSpace = '';
  zoneSeleccionada: number | null = null;
  plantaSeleccionada = -1;
  isLoading = false; // indicador de càrrega per a crides asíncrones

  constructor(
    private spacesService: SpacesService,
    private notif: NotificationService
  ) {}

  ngOnInit(): void {
    // Subscriure'ns a l'stream de zones per tenir la llista actualitzada
    this.spacesService.zones$
      .pipe(takeUntil(this.destroy$))
      .subscribe(zones => {
        this.zones = zones;
      });

    // Carregar espais per la planta inicial
    this.carregarSpacesPerPlanta(this.plantaSeleccionada);
  }

  ngOnDestroy(): void {
    // Cancel·lar subscripcions i netejar recursos
    this.destroy$.next();
    this.destroy$.complete();
  }

  // ========== GESTIÓ DE PLANTES ==========

  private carregarSpacesPerPlanta(planta: number): void {
    // Marcar com a carregant mentre fem la crida al servei
    this.isLoading = true;

    this.spacesService.getSpacesByFloor(planta)
      .pipe(takeUntil(this.destroy$))
      .subscribe({
        next: (spaces) => {
          // Mapear els espais per aplicar color segons la zona
          this.spacesPlantaActual = this.mapSpacesWithColorsByZone(spaces);
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

  onPlantaSeleccionada(plantaNumero: number): void {
    // Actualitzar planta seleccionada, cancel·lar qualsevol acció pendent i recarregar
    this.plantaSeleccionada = plantaNumero;
    this.cancelarAccio();
    this.carregarSpacesPerPlanta(plantaNumero);
  }

  private mapSpacesWithColorsByZone(spaces: Space[]): SpaceDisplay[] {
    return spaces.map(space => ({
      ...space,
      color: this.spacesService.getColorPerZona(space.zone_id),
      floor: space.floor ?? this.plantaSeleccionada
    }));
  }

  // ========== CREAR ESPAI ==========

  iniciarCrearSpace(): void {
    // Preparar l'estat per crear un nou espai
    this.modeEditor = 'create';
    this.puntsTemporals = [];
    this.nomNouSpace = '';
    this.zoneSeleccionada = null;
  }

  finalitzarSpace(): void {
    // Validacions mínimes per crear un espai
    if (this.puntsTemporals.length < 3) {
      this.notif.error('Un espai necessita almenys 3 punts');
      return;
    }

    if (!this.nomNouSpace.trim()) {
      this.notif.error('Introdueix un nom per l\'espai');
      return;
    }

    if (!this.zoneSeleccionada) {
      this.notif.error('Selecciona una zona per l\'espai');
      return;
    }

    this.isLoading = true;

    // Construir l'objecte per enviar al servei (sense camps automàtics)
    const nouSpace: Omit<Space, 'id' | 'created_at' | 'updated_at'> = {
      name: this.nomNouSpace.trim(),
      zone_id: this.zoneSeleccionada,
      status: 'unverified',
      coordinates: [...this.puntsTemporals],
      floor: this.plantaSeleccionada
    };

    // Cridar servei per crear l'espai i actualitzar la vista en cas d'èxit
    this.spacesService.crearSpace(nouSpace).subscribe({
      next: () => {
        this.carregarSpacesPerPlanta(this.plantaSeleccionada);
        this.cancelarAccio();
        this.notif.info('Espai creat correctament');
        this.isLoading = false;
      },
      error: (error) => {
        this.isLoading = false;
        console.error('Error creant espai:', error);
        this.notif.error('Error al crear l\'espai. Torna-ho a intentar.');
      }
    });
  }

  // ========== EDITAR ESPAI ==========

  iniciarEditarSpace(): void {
    // Preparar l'estat per editar un espai
    this.modeEditor = 'edit';
    this.spaceEditant = null;
    this.puntsTemporals = [];
    this.nomNouSpace = '';
    this.zoneSeleccionada = null;
  }

  actualitzarSpace(): void {
    if (!this.spaceEditant || !this.spaceEditant.id) return;

    // Validacions com en la creació
    if (this.puntsTemporals.length < 3) {
      this.notif.error('Un espai necessita almenys 3 punts');
      return;
    }

    if (!this.nomNouSpace.trim()) {
      this.notif.error('Introdueix un nom per l\'espai');
      return;
    }

    if (!this.zoneSeleccionada) {
      this.notif.error('Selecciona una zona per l\'espai');
      return;
    }

    this.isLoading = true;

    // Construir l'objecte parcial amb els canvis
    const spaceActualitzat: Partial<Space> = {
      name: this.nomNouSpace.trim(),
      zone_id: this.zoneSeleccionada,
      coordinates: [...this.puntsTemporals],
      floor: this.plantaSeleccionada
    };

    // Cridar servei per actualitzar i reflectir canvis
    this.spacesService.actualitzarSpace(this.spaceEditant.id, spaceActualitzat).subscribe({
      next: () => {
        this.carregarSpacesPerPlanta(this.plantaSeleccionada);
        this.cancelarAccio();
        this.notif.info('Espai actualitzat correctament');
        this.isLoading = false;
      },
      error: (error) => {
        this.isLoading = false;
        console.error('Error actualitzant espai:', error);
        this.notif.error('Error al actualitzar l\'espai. Torna-ho a intentar.');
      }
    });
  }

  // ========== ELIMINAR ESPAI ==========

  iniciarEliminarSpace(): void {
    // Posar el mode a 'delete' perquè el clic a l'svg elimini espais
    this.modeEditor = 'delete';
  }

  eliminarSpace(spaceId: number): void {
    this.isLoading = true;

    // Cridar servei per eliminar l'espai i actualitzar la vista
    this.spacesService.eliminarSpace(spaceId).subscribe({
      next: () => {
        this.carregarSpacesPerPlanta(this.plantaSeleccionada);
        this.notif.info('Espai eliminat correctament');
        this.isLoading = false;
      },
      error: (error) => {
        this.isLoading = false;
        console.error('Error eliminant espai:', error);
        this.notif.error('Error al eliminar l\'espai. Torna-ho a intentar.');
      }
    });
  }

  // ========== INTERACCIÓ AMB SVG ==========

  onSvgClick(punt: Punt): void {
    // Comportament del clic segons el mode d'edició
    if (this.modeEditor === 'create') {
      this.afegirPuntSpace(punt);
    } else if (this.modeEditor === 'edit') {
      if (!this.spaceEditant) {
        // Si no hi ha cap espai seleccionat per editar, intentar seleccionar-ne un
        this.seleccionarSpacePerEditar(punt);
      } else {
        // Si ja s'està editant un espai, afegir punts al poligon
        this.afegirPuntSpace(punt);
      }
    } else if (this.modeEditor === 'delete') {
      // En mode eliminar, el clic a l'svg elimina l'espai clicat
      this.eliminarSpaceClick(punt);
    }
  }

  afegirPuntSpace(punt: Punt): void {
    // Afegir un punt temporal al poligon i notificar
    this.puntsTemporals.push(punt);
    this.notif.info('Punt afegit');
  }

  seleccionarSpacePerEditar(punt: Punt): void {
    // Buscar quin espai conté el punt clicat i preparar-lo per editar
    for (const space of this.spacesPlantaActual) {
      if (this.puntDinsSpace(punt, space.coordinates)) {
        this.spaceEditant = space;
        this.puntsTemporals = [...space.coordinates];
        this.nomNouSpace = space.name;
        this.zoneSeleccionada = space.zone_id;
        break;
      }
    }
  }

  eliminarSpaceClick(punt: Punt): void {
    const space = this.spacesPlantaActual.find(s =>
      this.puntDinsSpace(punt, s.coordinates)
    );
    // Si el clic correspon a un espai, eliminar-lo
    if (space && space.id) {
      this.eliminarSpace(space.id);
    }
  }

  eliminarPuntSpaceEdit(index: number): void {
    // Eliminar un punt del poligon en edició
    this.puntsTemporals.splice(index, 1);
    this.notif.info('Punt eliminat');
  }

  // ========== FILTRAR PER ZONA ==========

  filtrarPerZona(zoneId: number | null): void {
    if (!zoneId) {
      this.carregarSpacesPerPlanta(this.plantaSeleccionada);
      return;
    }

    this.isLoading = true;

    this.spacesService.getSpacesByFloorAndZone(this.plantaSeleccionada, zoneId)
      .pipe(takeUntil(this.destroy$))
      .subscribe({
        next: (spaces) => {
          // Actualitzar la vista amb els espais filtrats per zona
          this.spacesPlantaActual = this.mapSpacesWithColorsByZone(spaces);
          this.isLoading = false;
        },
        error: (error) => {
          console.error('Error carregant spaces per zona:', error);
          this.notif.error('Error al carregar els espais');
          this.isLoading = false;
        }
      });
  }

  // ========== UTILITATS ==========

  cancelarAccio(): void {
    // Restaurar l'estat del component després d'una acció (crear/editar/eliminar)
    this.modeEditor = 'none';
    this.puntsTemporals = [];
    this.spaceEditant = null;
    this.nomNouSpace = '';
    this.zoneSeleccionada = null;
  }

  puntDinsSpace(punt: Punt, poligon: Punt[]): boolean {
    let dins = false;
    for (let i = 0, j = poligon.length - 1; i < poligon.length; j = i++) {
      const xi = poligon[i].x, yi = poligon[i].y;
      const xj = poligon[j].x, yj = poligon[j].y;

      const intersect = ((yi > punt.y) !== (yj > punt.y))
        && (punt.x < (xj - xi) * (punt.y - yi) / (yj - yi) + xi);

      if (intersect) dins = !dins;
    }
    return dins;
  }

  getZoneName(zoneId: number): string {
    // Obtenir el nom d'una zona pel seu id via el servei
    return this.spacesService.getZoneName(zoneId) || '';
  }

  getColorZona(zoneId: number): string {
    // Obtenir el color associat a una zona
    return this.spacesService.getColorPerZona(zoneId);
  }
}