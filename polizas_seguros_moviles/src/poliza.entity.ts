import { Entity, Column, PrimaryGeneratedColumn, CreateDateColumn } from 'typeorm';

@Entity()
export class Poliza {
  @PrimaryGeneratedColumn('uuid')
  id: string;

  @Column()
  propietario: string;

  @Column('decimal')
  valor_auto: number;

  @Column({ length: 1 })
  modelo: string; // A, B, C

  @Column()
  edad_rango: string; // 18-23, 23-55, 55+

  @Column('int')
  accidentes: number;

  @Column('decimal')
  costo_total: number;

  @CreateDateColumn()
  fecha_creacion: Date;
}
