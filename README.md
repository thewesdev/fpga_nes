# FPGA Nes

implementação do console nes em uma fpga.

mais detalhes abaixo.

## Sumário
- [1. FPGA](#1-fpga)
    - [1.1 Placa e Chip](#11-placa-e-chip)
    - [1.2 Quartus](#12-quartus)
    - [1.3 Clocks](#13-clocks)
    - [1.4 Pinos](#14-pinos)
- [2. Como rodar](#2-como-rodar)
    - [2.1 Pré-requisitos](#21-pré-requisitos)
    - [2.2 Distrobox](#22-distrobox)
    - [2.3 Compilar/Gravar](#23-compilargravar)
    - [2.4 Simulação](#24-simulação)
- [3. Estrutura do Repositório](#3-estrutura-do-repositório)
- [4. Estado do Projeto](#4-estado-do-projeto)
    - [4.1 Significados dos Status](#41-significados-dos-status)
    - [4.2 Módulos](#42-módulos)
    - [4.3 Instruções do RP2A03](#43-instruções-rp2a03)
    - [4.4 Mappers](#44-mappers)
- [5. referências](#5-referências)
- [6. licença](#6-licença)

## 1. FPGA

### 1.1 Placa e Chip

A placa utilizada é uma Altera DE1 Board com chip Cyclone II EP2C20F484C7.

podem ser encontradas mais informações [aqui](https://www.terasic.com.tw/cgi-bin/page/archive.pl?Language=English&CategoryNo=183&No=83&PartNo=2#contents).

> [!WARNING]
> Todos os testes e execuções estão sendo feitos exclusivamente nessa placa, então não é garantido que funcione em outras.

### 1.2 Quartus

É utilizado o Quartus II Web Edition 13.0sp1, que pode ser encontrado para download [aqui](https://www.altera.com/downloads/fpga-development-tools/quartus-ii-web-edition-design-software-version-13-0sp1-linux).

> [!IMPORTANT]
> Os arquivos `.qsf` e `.qpf` são gerados a partir do [setup.tcl](./setup.tcl), portanto recomenda-se não editar o arquivo à mão, pois será sobrescrito no próximo uso do setup.tcl.

### 1.3 Clocks

Está sendo utilizado um clock de 24 MHz fornecido pelo USB Blaster que é usado como clock input junto com um multiplicador de 17 e divisor de 19, para o PLL, sendo retornado uma aproximação do Master Clock do NES.

As restrições para esse clock podem ser encontradas no arquivo [src/nes.sdc](./src/nes.sdc)

> [!NOTE]
> uma melhor aproximação seria 27 MHz com multiplicador 35 e divisor 44, no entanto, esses valores ultrapassam os limítes de multiplicadores e divisores.

### 1.4 Pinos

| Pinos   | Nome do fio    | Descrição                                 |
| ------- | -------------- | ----------------------------------------- |
| PIN_R20 | LED_RST        | led aceso quando rst está ativo           |
| PIN_U22 | LED_RUNNING    | led aceso quando rst está desativado      |
| PIN_U21 | LED_MASTER_CLK | led acende conforme o master clock oscila |
| PIN_A12 | CLK_24         | Clock 24 MHz de input                     |

## 2. Como Rodar

### 2.1 Pré-requisitos

- Uma cópia deste repositório
- Um ambiente compatível com as ferramentas de desenvolvimento
- Para simulação é preciso de iverilog e gtkwave.
- Uma Altera DE1 Board para gravação do circuito.

### 2.2 Distrobox

É recomendado o uso de uma distrobox em uma distribuição mais antiga, como Ubuntu 18.04, que tem ferramentas em versões compatíveis com o Quartus II.

### 2.3 Compilar/Gravar

```bash
git clone https://github.com/thewesdev/fpga_nes # git clone git@github.com:thewesdev/fpga_nes
cd fpga_nes
./scripts/compile.sh
./scripts/flash.sh
```

### 2.4 Simulação

> [!NOTE]
> Um testbench de um módulo pode ter mais de 1 teste.

```bash
# o comando pode ser diferente a depender do seu OS
sudo dnf install iverilog gtkwave
```

```bash
# para rodar os testes de um único módulo
./scripts/test_one.sh

# para rodar todos os testes
./scripts/test_all.sh

# para visualizar a forma de onda gerada por um único teste de um módulo
./scripts/wave_view.sh
```

## 3. Estrutura do Repositório

```bash
.
├── .git
├── .github
├── compile # gerado durante a compilação
├── db # gerado durante o setup e compilação
├── incremental_db # gerado durante a compilação
├── logs # gerado durante a compilação e flash
├── references # pasta com referências usadas durante o projeto
├── scripts # scripts utilitários
├── src # código fonte
├── testbench # testes
├── .editorconfig
├── .gitattributes
├── .gitignore
├── AGENTS.md
├── LICENSE
├── nes.qpf # gerado durante a compilação, na etapa de setup
├── nes.qsf # gerado durante a compilação, na etapa de setup
├── README.md
└── setup.tcl # arquivo usado pelo setup para gerar nes.qpf e nes.qsf
```

## 4. Estado do Projeto

### 4.1 Significados dos Status

| Emoji | Estado           |
| ----- | ---------------- |
|  ⬜   | não implementado |
|  🚧   | em construção    |
|  ✅   | implementado     |

### 4.2 Módulos

| Módulo      | Status |
| ----------- | ------ |
| decoder     |   ✅   |
| cpu         |   🚧   |
| apu         |   ⬜   |
| ppu         |   ⬜   |
| sram        |   🚧   |
| controles   |   ⬜   |
| cartridge   |   ⬜   |
| vga         |   ⬜   |

### 4.3 Instruções RP2A03

| Instrução | Status |
| --------- | ------ |
| ADC       |   ⬜   |
| AND       |   ⬜   |
| ASL       |   ⬜   |
| BCC       |   ⬜   |
| BCS       |   ⬜   |
| BEQ       |   ⬜   |
| BIT       |   ⬜   |
| BMI       |   ⬜   |
| BNE       |   ⬜   |
| BPL       |   ⬜   |
| BRK       |   ⬜   |
| BVC       |   ⬜   |
| BVS       |   ⬜   |
| CLC       |   ⬜   |
| CLD       |   ⬜   |
| CLI       |   ⬜   |
| CLV       |   ⬜   |
| CMP       |   ⬜   |
| CPX       |   ⬜   |
| CPY       |   ⬜   |
| DEC       |   ⬜   |
| DEX       |   ⬜   |
| DEY       |   ⬜   |
| EOR       |   ⬜   |
| INC       |   ⬜   |
| INX       |   ⬜   |
| INY       |   ⬜   |
| JMP       |   ⬜   |
| JSR       |   ⬜   |
| LDA       |   ⬜   |
| LDX       |   ⬜   |
| LDY       |   ⬜   |
| LSR       |   ⬜   |
| NOP       |   ⬜   |
| ORA       |   ⬜   |
| PHA       |   ⬜   |
| PHP       |   ⬜   |
| PLA       |   ⬜   |
| PLP       |   ⬜   |
| ROL       |   ⬜   |
| ROR       |   ⬜   |
| RTI       |   ⬜   |
| RTS       |   ⬜   |
| SBC       |   ⬜   |
| SEC       |   ⬜   |
| SED       |   ⬜   |
| SEI       |   ⬜   |
| STA       |   ⬜   |
| STX       |   ⬜   |
| STY       |   ⬜   |
| TAX       |   ⬜   |
| TAY       |   ⬜   |
| TSX       |   ⬜   |
| TXA       |   ⬜   |
| TXS       |   ⬜   |
| TYA       |   ⬜   |


### 4.4 Mappers

| Mapper | Status |
| ------ | ------ |
| SxROM  |   ⬜   |
| TxROM  |   ⬜   |
| NROM   |   ⬜   |
| UxROM  |   ⬜   |
| CxROM  |   ⬜   |
| AxROM  |   ⬜   |
| ExROM  |   ⬜   |
| PxROM  |   ⬜   |
| FxROM  |   ⬜   |
| GxROM  |   ⬜   |
| TxSROM |   ⬜   |

## 5. referências

Consulte [aqui](./references/README.md).

## 6. licença

Este projeto utiliza a licença MIT, que pode ser encontrada [aqui](./LICENSE).