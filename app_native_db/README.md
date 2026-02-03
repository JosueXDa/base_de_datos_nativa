# App Native DB - Arquitectura y Documentación

Este proyecto implementa una aplicación móvil para la gestión y cálculo de pólizas de seguro de autos, siguiendo los principios de **Clean Architecture** y **Atomic Design**.

## 🏗 Arquitectura

El proyecto está estructurado en tres capas principales, asegurando la separación de responsabilidades y la escalabilidad del código:

### 1. Domain (Dominio)
Es el núcleo de la aplicación. Contiene la lógica de negocio pura y clases que modelan el problema, sin depender de librerías externas o frameworks de interfaz de usuario.

-   **Entities**: Objetos fundamentales del negocio.
    -   `PolizaRequest`: Representa los datos de entrada necesarios para cotizar una póliza (propietario, edad, modelo, valor, accidentes).
    -   `PolizaCost`: Representa el resultado del cálculo de la póliza (costo total, desglose).
-   **Repositories (Interfaces)**: Define los contratos que deben cumplir los repositorios de datos, permitiendo la inversión de dependencias.
    -   `PolicyRepository`: Contrato para la creación/cálculo de pólizas.
-   **Use Cases**: Encapsulan reglas de negocio específicas de la aplicación.
    -   `CreatePolicyUseCase`: Orquestador que recibe una petición de póliza y delega la operación al repositorio.

### 2. Data (Datos)
Implementa la lógica de acceso a datos definida en la capa de dominio.

-   **Repositories (Implementación)**:
    -   `PolicyRepositoryImpl`: Implementación concreta de `PolicyRepository`. Coordina la obtención de datos desde las fuentes de datos (Data Sources).
-   **Data Sources**:
    -   `PolicyRemoteDataSource`: Encargado de la comunicación con servicios externos (API REST) para realizar los cálculos o persistencia.

### 3. Presentation (Presentación)
Responsable de la interfaz de usuario y la gestión del estado visual.

-   **State Management (Riverpod)**:
    -   `PolicyNotifier`: Gestiona el estado de la pantalla de pólizas. Se encarga de llamar al caso de uso `CreatePolicyUseCase` y actualizar la UI con estados de carga (`AsyncValue.loading`), éxito (`AsyncValue.data`) o error (`AsyncValue.error`).
-   **UI Structure (Atomic Design)**:
    -   **Atoms**: Componentes indivisibles y básicos (ej. `AppText`).
    -   **Molecules**: Grupos de átomos funcionales.
    -   **Organisms**: Componentes complejos que forman secciones de la UI (ej. `PolicyForm`).
    -   **Pages**: Pantallas completas que ensamblan organismos (ej. `PolicyPage`).

## 💻 Explicación del Código

### Flujo de Creación de Póliza
1.  **Usuario**: Ingresa los datos en `PolicyPage` a través del formulario `PolicyForm`.
2.  **Provider**: `PolicyNotifier.calculatePolicy()` es invocado con los datos del formulario.
3.  **UseCase**: El provider construye el `PolizaRequest` y llama a `CreatePolicyUseCase`.
4.  **Repository**: El caso de uso delega al `PolicyRepositoryImpl`.
5.  **DataSource**: El repositorio usa `PolicyRemoteDataSource` para enviar los datos a la API (o simular el cálculo).
6.  **Respuesta**: El resultado (`PolizaCost`) fluye de regreso hasta el Provider, que actualiza el estado, provocando la reconstrucción de la UI para mostrar los resultados.

## 🎨 Construcción de la Interfaz

La interfaz se construye utilizando **Flutter** y sigue el patrón **Atomic Design** para maximizar la reutilización:

-   **`lib/presentation/pages/policy_page.dart`**:
    -   Es la pantalla principal.
    -   Usa un `Scaffold` con un `AppBar`.
    -   Escucha los cambios de estado mediante `ref.watch(policyNotifierProvider)`.
    -   Renderiza el formulario (`PolicyForm`) y, condicionalmente, la sección de resultados si el cálculo fue exitoso.
    -   La sección de resultados muestra detalles como el propietario, modelo y costo total formateado.

-   **Diseño Modular**:
    -   Los componentes complejos como el formulario se extraen a **Organisms** (`PolicyForm`), manteniendo la página limpia y enfocada en el ensamblaje y visualización del estado.
    -   Los estilos de texto y elementos básicos se centralizan en **Atoms**, asegurando consistencia visual en toda la app.
