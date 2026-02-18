// Imports principals d'Angular i utilitats
import { Component, ViewChild, ElementRef, Input, Output, EventEmitter, inject, OnInit, OnDestroy } from "@angular/core"
import { CommonModule } from "@angular/common"
import { FormsModule } from "@angular/forms"

// Models de dades utilitzats pel component
import { Punt } from "../../models/punt/punt"
import { Planta } from "../../models/planta/planta"
import { SpaceDisplay } from "../../models/SpaceDisplay/space-display"

// Serveis per obtenir dades de plantes i espais
import { PlantaService } from "../../services/planta/planta"
import { SpacesService } from "../../services/spaces/spaces"

// RxJS per fer polls periòdics
import { interval, Subscription } from "rxjs"


// Tipus que defineix els diferents modes d'edició possibles
type ModeEditor = 'none' | 'create' | 'edit' | 'delete'

// Tipus per al mode de colorització del mapa (per zona o per estat)
export type ColorMode = 'zone' | 'status'

@Component({
  selector: "app-home",
  standalone: true,
  imports: [CommonModule, FormsModule],
  templateUrl: "./home.html",
  styleUrls: ["./home.css"],
})
export class Home implements OnInit, OnDestroy {

  // Referència a l'element <img> que mostra el plànol/imatge
  @ViewChild('imgRef', { read: ElementRef }) imgRef!: ElementRef<HTMLImageElement>

  // Dades entrades pel component
  @Input() spaces: SpaceDisplay[] = []                // llista d'espais a mostrar
  @Input() modeEditor: ModeEditor = 'none'           // mode d'edició actual
  @Input() puntsTemporals: Punt[] = []               // punts temporals per a visualitzar
  @Input() colorMode: ColorMode = 'zone'             // com es pinten els espais
  @Input() zoneId?: number;                         // ID de zona per filtrar espais

  // Si està activat, es pot canviar l'estat dels espais fent clic
  @Input() modeResponsable: boolean = false

  // Esdeveniments sortida
  @Output() plantaChange = new EventEmitter<number>()    // quan canvia la planta seleccionada
  @Output() svgClick = new EventEmitter<Punt>()          // quan es fa clic al plànol
  @Output() spaceStatusToggle = new EventEmitter<SpaceDisplay>() // per alternar l'estat d'un espai

  // Injecció dels serveis usant la síntaxi d'Angular standalone
  private plantaService = inject(PlantaService)
  private spacesService = inject(SpacesService)
  private statsIntervalSub?: Subscription

  // Estat intern del component relacionat amb la planta i la visualització
  plantaSeleccionada = -1   // número de la planta seleccionada (-1 = cap)
  punt = Punt               // referència al tipus Punt (s'utilitza per a construir punts)
  planta = Planta           // referència al tipus Planta

  // Paràmetres de zoom i pan per a la visualització del plànol
  zoomLevel = 1
  panX = 0
  panY = 0

  // Estadístiques del drag per diferenciar clic vs arrossegament
  isDragging = false
  lastX = 0
  lastY = 0
  dragStartTime = 0
  dragDistance = 0

  // Map que guarda estadístiques per cada planta: total i no verificats
  statsPerPlanta: Map<number, { total: number, noVerificats: number }> = new Map()

  ngOnInit(): void {
    // Al iniciar, carregar les estadístiques per planta
    this.carregarEstadistiquesPlantes()

    // Fer polling cada 5 segons per actualitzar les estadístiques
    this.statsIntervalSub = interval(5000).subscribe(() => {
      this.carregarEstadistiquesPlantes()
    })
  }

  ngOnDestroy(): void {
    // Cancel·lar el polling quan el component es destrueix
    this.statsIntervalSub?.unsubscribe()
  }

  private carregarEstadistiquesPlantes(): void {
    this.plantes.forEach(planta => {

      const request$ = this.modeResponsable && this.zoneId
        ? this.spacesService.getSpacesByFloorAndZone(planta.numero, this.zoneId)
        : this.spacesService.getSpacesByFloor(planta.numero);

      request$.subscribe({
        next: (spaces) => {
          const noVerificats = spaces.filter(
            s => s.status === 'unverified'
          ).length;

          this.statsPerPlanta.set(planta.numero, {
            total: spaces.length,
            noVerificats
          });
        },
        error: (error) => {
          console.error(
            `Error carregant espais de planta ${planta.numero}:`,
            error
          );
        }
      });
    });
  }


  getNoVerificatsPlanta(numeroPlanta: number): number {
    // Retorna el nombre d'espais no verificats per la planta indicada
    return this.statsPerPlanta.get(numeroPlanta)?.noVerificats ?? 0
  }

  get plantes(): Planta[] {
    // Obtenir la llista de plantes des del servei
    return this.plantaService.getPlantes()
  }

  get nomPlantaSeleccionada(): string {
    // Nom de la planta seleccionada o cadena per defecte
    const planta = this.plantaService.getPlantaByNumero(this.plantaSeleccionada)
    return planta?.nom || 'Selecciona una planta'
  }

  get plantaActual(): Planta | undefined {
    // Planta seleccionada com a objecte (o undefined si no n'hi ha)
    return this.plantaService.getPlantaByNumero(this.plantaSeleccionada)
  }

  get spacesPlantaActual(): SpaceDisplay[] {
    // Espais filtrats per la planta actual (actualment directe de l'input)
    return this.spaces
  }

  seleccionarPlanta(numero: number) {
    // Canvia la planta seleccionada i emet l'esdeveniment cap a l'exterior
    this.plantaSeleccionada = numero
    this.plantaChange.emit(this.plantaSeleccionada)
  }

  resetView() {
    // Restaurar zoom i posició per defecte
    this.zoomLevel = 1
    this.panX = 0
    this.panY = 0
  }

  zoomIn() {
    // Augmentar el zoom fins a un màxim
    this.zoomLevel = Math.min(this.zoomLevel + 0.25, 4)
  }

  zoomOut() {
    // Reduir el zoom sense baixar de 1
    if (this.zoomLevel > 1) {
      this.zoomLevel = Math.max(this.zoomLevel - 0.25, 1)
    }
  }

  onMouseDown(event: MouseEvent) {
    // Iniciar el procés d'arrossegament (pan)
    this.isDragging = true
    this.lastX = event.clientX
    this.lastY = event.clientY
    this.dragStartTime = Date.now()
    this.dragDistance = 0
  }

  onMouseMove(event: MouseEvent) {
    // Quan s'arrossega, actualitzar el pan i la distància arrossegada
    if (this.isDragging) {
      const deltaX = event.clientX - this.lastX
      const deltaY = event.clientY - this.lastY
      this.dragDistance += Math.abs(deltaX) + Math.abs(deltaY)

      this.panX += deltaX
      this.panY += deltaY
      this.lastX = event.clientX
      this.lastY = event.clientY
    }
  }

  onMouseUp() {
    // Finalitzar l'arrossegament
    this.isDragging = false
  }

  getTransform() {
    // Transform CSS per aplicar pan i zoom a l'element que conté el plànol
    return `translate(${this.panX}px, ${this.panY}px) scale(${this.zoomLevel})`
  }

  onSvgClick(event: MouseEvent) {
    // Determinar si el moviment ha estat un clic curt (no arrossegament)
    const dragTime = Date.now() - this.dragStartTime
    const wasClick = this.dragDistance < 5 && dragTime < 200

    if (!wasClick || !this.imgRef) return

    // Calcular coordinates normalitzades (0..1) dins de la imatge
    const img = this.imgRef.nativeElement
    const rect = img.getBoundingClientRect()

    const x = (event.clientX - rect.left) / rect.width
    const y = (event.clientY - rect.top) / rect.height

    const clickedPoint = { x, y }

    // Si estem en mode responsable, intentar detectar si s'ha clicat un espai
    if (this.modeResponsable) {
      const clickedSpace = this.findSpaceAtPoint(clickedPoint)
      if (clickedSpace) {
        // Alternar l'estat de l'espai (emetre cap al component pare)
        this.spaceStatusToggle.emit(clickedSpace)
        return
      }
    }

    // Emissor del punt clicat normalitzat
    this.svgClick.emit(clickedPoint)
  }

  private findSpaceAtPoint(punt: Punt): SpaceDisplay | null {
    // Buscar l'espai que conté el punt utilitzant la funció de test de poligon
    for (const space of this.spacesPlantaActual) {
      if (this.puntDinsSpace(punt, space.coordinates)) {
        return space
      }
    }
    return null
  }

  private puntDinsSpace(punt: Punt, poligon: Punt[]): boolean {
    // Algoritme ray-casting per determinar si un punt està dins d'un poligon
    let dins = false
    for (let i = 0, j = poligon.length - 1; i < poligon.length; j = i++) {
      const xi = poligon[i].x, yi = poligon[i].y
      const xj = poligon[j].x, yj = poligon[j].y

      const intersect = ((yi > punt.y) !== (yj > punt.y))
        && (punt.x < (xj - xi) * (punt.y - yi) / (yj - yi) + xi)

      if (intersect) dins = !dins
    }
    return dins
  }

  getPuntsAbsoluts(punts: Punt[] | undefined | null): string {
    // Converteix punts normalitzats (0..1) a coordenades absolutes en píxels
    if (!this.imgRef || !Array.isArray(punts)) return ''

    const img = this.imgRef.nativeElement
    const width = img.clientWidth
    const height = img.clientHeight

    return punts.map(p => `${p.x * width},${p.y * height}`).join(' ')
  }

  getCentrePoligon(coordinates: Array<{ x: number, y: number }>): { x: number, y: number } {
    if (!coordinates || coordinates.length === 0) {
      return { x: 0, y: 0 };  
    }

    const imgWidth = this.imgRef?.nativeElement.clientWidth || 1;
    const imgHeight = this.imgRef?.nativeElement.clientHeight || 1;

    let sumX = 0;
    let sumY = 0;

    coordinates.forEach(coord => {
      sumX += coord.x * imgWidth;
      sumY += coord.y * imgHeight;
    });

    return {
      x: sumX / coordinates.length,
      y: sumY / coordinates.length
    };
  }
}