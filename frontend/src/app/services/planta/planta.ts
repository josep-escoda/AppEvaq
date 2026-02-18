import { Injectable } from '@angular/core';
import { Planta } from '../../models/planta/planta';

@Injectable({
  providedIn: 'root'
})
export class PlantaService {
  private plantes: Planta[] = [
    { numero: -1, nom: "Planta Semisoterrani", imatge: "assets/planta_semisoterrani.svg" },
    { numero: 0, nom: "Planta Baixa", imatge: "assets/planta_baixa.svg" },
    { numero: 1, nom: "Planta Primera", imatge: "assets/planta_primera.svg" },
    { numero: 2, nom: "Planta Segona", imatge: "assets/planta_segona.svg" },
    { numero: 3, nom: "Planta Tercera", imatge: "assets/planta_tercera.svg" },
    { numero: 4, nom: "Planta Quarta", imatge: "assets/planta_quarta.svg" },
  ];

  getPlantes(): Planta[] {
    return this.plantes;
  }

  getPlantaByNumero(numero: number): Planta | undefined {
    return this.plantes.find(p => p.numero === numero);
  }
}