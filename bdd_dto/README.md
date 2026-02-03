# API de Gestión de Pólizas de Seguros

API REST para la gestión de propietarios, automóviles, seguros y pólizas de seguros de vehículos.

## Información General

- **Base URL**: `http://localhost:9090/bdd_dto`
- **Puerto**: 9090
- **Base de Datos**: MySQL
- **Framework**: Spring Boot
- **Versión Java**: 17+

## Autenticación

En el presente, la API no requiere autenticación.

---

## Endpoints de la API

### 1. **PROPIETARIOS** (`/api/propietarios`)

#### 1.1 Crear Propietario
```
POST /api/propietarios
```

**Descripción**: Crea un nuevo propietario en el sistema.

**Body (JSON)**:
```json
{
  "nombreCompleto": "Juan Pérez García",
  "edad": 35
}
```

**Respuesta (201 Created)**:
```json
{
  "id": 1,
  "nombreCompleto": "Juan Pérez García",
  "edad": 35,
  "automovilIds": []
}
```

**Errores**:
- `400 Bad Request`: Datos inválidos

---

#### 1.2 Obtener Todos los Propietarios
```
GET /api/propietarios
```

**Descripción**: Obtiene la lista de todos los propietarios registrados.

**Respuesta (200 OK)**:
```json
[
  {
    "id": 1,
    "nombreCompleto": "Juan Pérez García",
    "edad": 35,
    "automovilIds": [1, 2]
  },
  {
    "id": 2,
    "nombreCompleto": "María López Rodríguez",
    "edad": 28,
    "automovilIds": [3]
  }
]
```

---

#### 1.3 Obtener Propietario por ID
```
GET /api/propietarios/{id}
```

**Descripción**: Obtiene los detalles de un propietario específico.

**Parámetros**:
- `id` (path): ID del propietario (Long)

**Ejemplo**: `GET /api/propietarios/1`

**Respuesta (200 OK)**:
```json
{
  "id": 1,
  "nombreCompleto": "Juan Pérez García",
  "edad": 35,
  "automovilIds": [1, 2]
}
```

**Errores**:
- `404 Not Found`: Propietario no existe

---

#### 1.4 Actualizar Propietario
```
PUT /api/propietarios/{id}
```

**Descripción**: Actualiza los datos de un propietario existente.

**Parámetros**:
- `id` (path): ID del propietario

**Body (JSON)**:
```json
{
  "nombreCompleto": "Juan Carlos Pérez García",
  "edad": 36
}
```

**Respuesta (200 OK)**:
```json
{
  "id": 1,
  "nombreCompleto": "Juan Carlos Pérez García",
  "edad": 36,
  "automovilIds": [1, 2]
}
```

**Errores**:
- `400 Bad Request`: Datos inválidos
- `404 Not Found`: Propietario no existe

---

#### 1.5 Eliminar Propietario
```
DELETE /api/propietarios/{id}
```

**Descripción**: Elimina un propietario del sistema.

**Parámetros**:
- `id` (path): ID del propietario

**Ejemplo**: `DELETE /api/propietarios/1`

**Respuesta (204 No Content)**: Sin cuerpo de respuesta

**Errores**:
- `404 Not Found`: Propietario no existe

---

### 2. **AUTOMÓVILES** (`/api/automoviles`)

#### 2.1 Crear Automóvil
```
POST /api/automoviles
```

**Descripción**: Crea un nuevo automóvil y asocia un seguro automáticamente.

**Body (JSON)**:
```json
{
  "modelo": "A",
  "valor": 25000.00,
  "accidentes": 0,
  "propietarioId": 1
}
```

**Campos requeridos**:
- `modelo` (String): Tipo de modelo (A, B o C - case insensitive)
- `valor` (Double): Valor del vehículo (debe ser positivo)
- `accidentes` (Integer): Número de accidentes (≥ 0)
- `propietarioId` (Long): ID del propietario propietario

**Respuesta (201 Created)**:
```json
{
  "id": 1,
  "modelo": "A",
  "valor": 25000.00,
  "accidentes": 0,
  "propietarioId": 1,
  "propietarioNombreC": "Juan Pérez García",
  "costoSeguro": 1000.00,
  "seguroId": 1
}
```

**Errores**:
- `400 Bad Request`: Datos inválidos, modelo no válido, o propietario no existe
- Validaciones:
  - `modelo`: Debe ser A, B o C (case insensitive)
  - `valor`: Debe ser un número positivo
  - `accidentes`: Debe ser 0 o mayor

---

#### 2.2 Obtener Todos los Automóviles
```
GET /api/automoviles
```

**Descripción**: Obtiene la lista de todos los automóviles registrados.

**Respuesta (200 OK)**:
```json
[
  {
    "id": 1,
    "modelo": "A",
    "valor": 25000.00,
    "accidentes": 0,
    "propietarioId": 1,
    "propietarioNombreC": "Juan Pérez García",
    "costoSeguro": 1000.00,
    "seguroId": 1
  },
  {
    "id": 2,
    "modelo": "B",
    "valor": 35000.00,
    "accidentes": 1,
    "propietarioId": 1,
    "propietarioNombreC": "Juan Pérez García",
    "costoSeguro": 1400.00,
    "seguroId": 2
  }
]
```

---

#### 2.3 Obtener Automóvil por ID
```
GET /api/automoviles/{id}
```

**Descripción**: Obtiene los detalles de un automóvil específico.

**Parámetros**:
- `id` (path): ID del automóvil

**Ejemplo**: `GET /api/automoviles/1`

**Respuesta (200 OK)**:
```json
{
  "id": 1,
  "modelo": "A",
  "valor": 25000.00,
  "accidentes": 0,
  "propietarioId": 1,
  "propietarioNombreC": "Juan Pérez García",
  "costoSeguro": 1000.00,
  "seguroId": 1
}
```

**Errores**:
- `404 Not Found`: Automóvil no existe

---

#### 2.4 Actualizar Automóvil
```
PUT /api/automoviles/{id}
```

**Descripción**: Actualiza los datos de un automóvil existente y recalcula el seguro.

**Parámetros**:
- `id` (path): ID del automóvil

**Body (JSON)**:
```json
{
  "modelo": "B",
  "valor": 30000.00,
  "accidentes": 1,
  "propietarioId": 1
}
```

**Respuesta (200 OK)**:
```json
{
  "id": 1,
  "modelo": "B",
  "valor": 30000.00,
  "accidentes": 1,
  "propietarioId": 1,
  "propietarioNombreC": "Juan Pérez García",
  "costoSeguro": 1200.00,
  "seguroId": 1
}
```

**Errores**:
- `400 Bad Request`: Datos inválidos
- `404 Not Found`: Automóvil no existe

---

#### 2.5 Eliminar Automóvil
```
DELETE /api/automoviles/{id}
```

**Descripción**: Elimina un automóvil del sistema (y su seguro asociado).

**Parámetros**:
- `id` (path): ID del automóvil

**Ejemplo**: `DELETE /api/automoviles/1`

**Respuesta (204 No Content)**: Sin cuerpo de respuesta

**Errores**:
- `404 Not Found`: Automóvil no existe

---

### 3. **SEGUROS** (`/api/seguros`)

#### 3.1 Obtener Seguro por Automóvil
```
GET /api/seguros/automovil/{automovilId}
```

**Descripción**: Obtiene el seguro asociado a un automóvil específico.

**Parámetros**:
- `automovilId` (path): ID del automóvil

**Ejemplo**: `GET /api/seguros/automovil/1`

**Respuesta (200 OK)**:
```json
{
  "id": 1,
  "costoTotal": 1000.00,
  "automovilId": 1
}
```

**Cálculo del Costo**:
- **Base**: 4% del valor del automóvil
- **Edad del propietario**: +2% si es mayor a 60 años
- **Accidentes**: +10% por cada accidente

Fórmula: `costoTotal = (valor * 0.04) * (1 + 0.02 * edadMayor60) * (1 + 0.10 * accidentes)`

**Errores**:
- `404 Not Found`: Automóvil o seguro no existe

---

#### 3.2 Recalcular Seguro
```
POST /api/seguros/recalcular/{automovilId}
```

**Descripción**: Recalcula el costo del seguro basado en los datos actuales del automóvil.

**Parámetros**:
- `automovilId` (path): ID del automóvil

**Ejemplo**: `POST /api/seguros/recalcular/1`

**Respuesta (200 OK)**:
```json
{
  "id": 1,
  "costoTotal": 1000.00,
  "automovilId": 1
}
```

**Errores**:
- `400 Bad Request`: Error en el cálculo
- `404 Not Found`: Automóvil o seguro no existe

---

#### 3.3 Eliminar Seguro
```
DELETE /api/seguros/automovil/{automovilId}
```

**Descripción**: Elimina el seguro asociado a un automóvil.

**Parámetros**:
- `automovilId` (path): ID del automóvil

**Ejemplo**: `DELETE /api/seguros/automovil/1`

**Respuesta (204 No Content)**: Sin cuerpo de respuesta

**Errores**:
- `404 Not Found`: Automóvil o seguro no existe

---

### 4. **PÓLIZAS** (`/api/poliza`)

#### 4.1 Crear Póliza Completa
```
POST /api/poliza
```

**Descripción**: Crea una póliza completa en una sola operación. Crea automáticamente el propietario, automóvil y calcula el seguro.

**Body (JSON)**:
```json
{
  "propietario": "Juan Pérez García",
  "edadPropietario": 35,
  "modeloAuto": "A",
  "valorSeguroAuto": 25000.00,
  "accidentes": 0
}
```

**Campos requeridos**:
- `propietario` (String): Nombre completo del propietario
- `edadPropietario` (Integer): Edad del propietario
- `modeloAuto` (String): Tipo de modelo (A, B o C)
- `valorSeguroAuto` (Double): Valor del automóvil
- `accidentes` (Integer): Número de accidentes

**Respuesta (200 OK)**:
```json
{
  "propietario": "Juan Pérez García",
  "modeloAuto": "A",
  "valorSeguroAuto": 25000.00,
  "edadPropietario": 35,
  "accidentes": 0,
  "costoTotal": 1000.00
}
```

**Errores**:
- `400 Bad Request`: Datos inválidos

---

#### 4.2 Obtener Póliza por Nombre de Usuario
```
GET /api/poliza/usuario?nombre={nombre}
```

**Descripción**: Obtiene la póliza de un propietario específico buscando por su nombre completo.

**Parámetros de consulta**:
- `nombre` (query): Nombre completo del propietario (requerido)

**Ejemplo**: `GET /api/poliza/usuario?nombre=Juan%20Pérez%20García`

**Respuesta (200 OK)**:
```json
{
  "propietario": "Juan Pérez García",
  "modeloAuto": "A",
  "valorSeguroAuto": 25000.00,
  "edadPropietario": 35,
  "accidentes": 0,
  "costoTotal": 1000.00
}
```

**Errores**:
- `404 Not Found`: Propietario no encontrado
- `400 Bad Request`: Parámetro `nombre` no proporcionado

---

## Modelos de Datos

### Propietario
```json
{
  "id": 1,
  "nombreCompleto": "Juan Pérez García",
  "edad": 35,
  "automovilIds": [1, 2]
}
```

### Automóvil
```json
{
  "id": 1,
  "modelo": "A",
  "valor": 25000.00,
  "accidentes": 0,
  "propietarioId": 1,
  "propietarioNombreC": "Juan Pérez García",
  "costoSeguro": 1000.00,
  "seguroId": 1
}
```

### Seguro
```json
{
  "id": 1,
  "costoTotal": 1000.00,
  "automovilId": 1
}
```

### Póliza
```json
{
  "propietario": "Juan Pérez García",
  "modeloAuto": "A",
  "valorSeguroAuto": 25000.00,
  "edadPropietario": 35,
  "accidentes": 0,
  "costoTotal": 1000.00
}
```

---

## Códigos de Respuesta HTTP

| Código | Descripción |
|--------|-------------|
| `200` | OK - Solicitud exitosa |
| `201` | Created - Recurso creado exitosamente |
| `204` | No Content - Solicitud exitosa sin contenido de respuesta |
| `400` | Bad Request - Solicitud inválida o error en los datos |
| `404` | Not Found - Recurso no encontrado |
| `500` | Internal Server Error - Error del servidor |

---

## Validaciones de Entrada

### Automóvil
- `modelo`: Obligatorio, debe ser A, B o C (case insensitive)
- `valor`: Obligatorio, debe ser un número positivo
- `accidentes`: Debe ser 0 o mayor
- `propietarioId`: Obligatorio, debe existir un propietario con este ID

### Propietario
- `nombreCompleto`: Obligatorio
- `edad`: Obligatorio

---

## Ejemplos de Uso Completos

### Flujo Completo: Crear Propietario, Automóvil y Consultar Póliza

#### 1. Crear un Propietario
```bash
curl -X POST http://localhost:9090/bdd_dto/api/propietarios \
  -H "Content-Type: application/json" \
  -d '{
    "nombreCompleto": "Carlos Mendoza López",
    "edad": 45
  }'
```

Respuesta:
```json
{
  "id": 1,
  "nombreCompleto": "Carlos Mendoza López",
  "edad": 45,
  "automovilIds": []
}
```

#### 2. Crear un Automóvil para el Propietario
```bash
curl -X POST http://localhost:9090/bdd_dto/api/automoviles \
  -H "Content-Type: application/json" \
  -d '{
    "modelo": "B",
    "valor": 35000.00,
    "accidentes": 1,
    "propietarioId": 1
  }'
```

Respuesta:
```json
{
  "id": 1,
  "modelo": "B",
  "valor": 35000.00,
  "accidentes": 1,
  "propietarioId": 1,
  "propietarioNombreC": "Carlos Mendoza López",
  "costoSeguro": 1540.00,
  "seguroId": 1
}
```

#### 3. Obtener el Seguro del Automóvil
```bash
curl -X GET http://localhost:9090/bdd_dto/api/seguros/automovil/1
```

Respuesta:
```json
{
  "id": 1,
  "costoTotal": 1540.00,
  "automovilId": 1
}
```

#### 4. Crear Póliza Completa (Alternativa Rápida)
```bash
curl -X POST http://localhost:9090/bdd_dto/api/poliza \
  -H "Content-Type: application/json" \
  -d '{
    "propietario": "Sandra García Rodríguez",
    "edadPropietario": 28,
    "modeloAuto": "C",
    "valorSeguroAuto": 45000.00,
    "accidentes": 0
  }'
```

Respuesta:
```json
{
  "propietario": "Sandra García Rodríguez",
  "modeloAuto": "C",
  "valorSeguroAuto": 45000.00,
  "edadPropietario": 28,
  "accidentes": 0,
  "costoTotal": 1800.00
}
```

#### 5. Obtener Póliza por Nombre
```bash
curl -X GET "http://localhost:9090/bdd_dto/api/poliza/usuario?nombre=Sandra%20García%20Rodríguez"
```

Respuesta:
```json
{
  "propietario": "Sandra García Rodríguez",
  "modeloAuto": "C",
  "valorSeguroAuto": 45000.00,
  "edadPropietario": 28,
  "accidentes": 0,
  "costoTotal": 1800.00
}
```

---

## Fórmula de Cálculo de Seguro

El costo total del seguro se calcula de la siguiente manera:

$$\text{costoTotal} = \text{valor} \times 0.04 \times (1 + 0.02 \times \text{edadMayor60}) \times (1 + 0.10 \times \text{accidentes})$$

Donde:
- **valor**: Valor del automóvil
- **edadMayor60**: 1 si la edad del propietario es mayor a 60 años, 0 en caso contrario
- **accidentes**: Número de accidentes

### Ejemplos de Cálculo

**Ejemplo 1**: Propietario de 35 años, automóvil de $25,000, sin accidentes
$$\text{costoTotal} = 25000 \times 0.04 \times (1 + 0.02 \times 0) \times (1 + 0.10 \times 0) = \$1,000$$

**Ejemplo 2**: Propietario de 62 años, automóvil de $35,000, 1 accidente
$$\text{costoTotal} = 35000 \times 0.04 \times (1 + 0.02 \times 1) \times (1 + 0.10 \times 1) = \$1,540$$

**Ejemplo 3**: Propietario de 28 años, automóvil de $45,000, sin accidentes
$$\text{costoTotal} = 45000 \times 0.04 \times (1 + 0.02 \times 0) \times (1 + 0.10 \times 0) = \$1,800$$

---

## Configuración

La aplicación se configura a través del archivo `application.properties`:

```properties
# Puerto
server.port=9090
server.servlet.context-path=/bdd_dto

# Base de Datos MySQL
spring.datasource.url=jdbc:mysql://${DB_HOST:localhost}:3306/${DB_NAME:dbb_dto_poliza}
spring.datasource.username=${DB_USER:app_user}
spring.datasource.password=${DB_PASSWORD:app_password}
```

---

## Ejecución

### Con Docker Compose
```bash
docker-compose up
```

### Localmente (requiere MySQL)
```bash
./mvnw spring-boot:run
```

---

## Autor

Proyecto de Base de Datos Nativas - BDD DTO

