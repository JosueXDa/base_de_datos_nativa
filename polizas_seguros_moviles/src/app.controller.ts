import { Controller, Get, Post, Body } from '@nestjs/common';
import { AppService } from './app.service';
import { CreatePolizaDto } from './create-poliza.dto';
import { Poliza } from './poliza.entity';

@Controller('api/polizas')
export class AppController {
  constructor(private readonly appService: AppService) {}

  @Post()
  create(@Body() createPolizaDto: CreatePolizaDto): Promise<Poliza> {
    return this.appService.create(createPolizaDto);
  }

  @Get()
  findAll(): Promise<Poliza[]> {
    return this.appService.findAll();
  }
}
