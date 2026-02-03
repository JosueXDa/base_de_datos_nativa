import { IsString, IsNotEmpty, IsNumber, IsIn, Min } from 'class-validator';

export class CreatePolizaDto {
  @IsString()
  @IsNotEmpty()
  propietario: string;

  @IsNumber()
  @Min(0)
  valorAuto: number;

  @IsString()
  @IsIn(['A', 'B', 'C'])
  modelo: string;

  @IsString()
  @IsIn(['18-23', '23-55', '55+'])
  edadRango: string;

  @IsNumber()
  @Min(0)
  numAccidentes: number; // Changed to match the user's example code input
}
