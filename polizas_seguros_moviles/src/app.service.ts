import { Injectable, Logger } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { Poliza } from './poliza.entity';
import { CreatePolizaDto } from './create-poliza.dto';

@Injectable()
export class AppService {
  constructor(
    @InjectRepository(Poliza)
    private polizaRepository: Repository<Poliza>,
  ) {}

  async create(createPolizaDto: CreatePolizaDto): Promise<Poliza> {
    const { propietario, valorAuto, modelo, edadRango, numAccidentes } = createPolizaDto;

    // --- LÓGICA DE CÁLCULO ---
    const cargoValor = valorAuto * 0.035;
    
    const coefModelo = { 'A': 0.011, 'B': 0.012, 'C': 0.015 };
    const cargoModelo = valorAuto * coefModelo[modelo];
    
    const costosEdad = { '18-23': 360, '23-55': 240, '55+': 430 };
    const cargoEdad = costosEdad[edadRango] || 0;

    let cargoAccidentes = numAccidentes <= 3 
        ? numAccidentes * 17 
        : (3 * 17) + ((numAccidentes - 3) * 21);

    const costoTotal = cargoValor + cargoModelo + cargoEdad + cargoAccidentes;

    const nuevaPoliza = this.polizaRepository.create({
      propietario,
      valor_auto: valorAuto, // Map DTO camelCase to Entity snake_case
      modelo,
      edad_rango: edadRango, // Map DTO camelCase to Entity snake_case
      accidentes: numAccidentes, // Map DTO camelCase to Entity snake_case
      costo_total: parseFloat(costoTotal.toFixed(2)),
    });
    Logger.log(`Creando póliza para ${propietario} con costo total: ${costoTotal.toFixed(2)}`);
    return this.polizaRepository.save(nuevaPoliza);
  }

  findAll(): Promise<Poliza[]> {
    return this.polizaRepository.find({ order: { fecha_creacion: 'DESC' } });
  }
}
