import { Module } from '@nestjs/common';
import { TypeOrmModule } from '@nestjs/typeorm';
import { AppController } from './app.controller';
import { AppService } from './app.service';
import { Poliza } from './poliza.entity';

@Module({
  imports: [
    TypeOrmModule.forRoot({
      type: 'postgres',
      host: 'localhost',
      port: 5432,
      username: 'user',
      password: 'password',
      database: 'polizas_db',
      entities: [Poliza],
      synchronize: true, // Auto-create tables (dev only)
    }),
    TypeOrmModule.forFeature([Poliza]),
  ],
  controllers: [AppController],
  providers: [AppService],
})
export class AppModule {}
