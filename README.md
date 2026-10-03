# fpga-nes

implementação do console nes em uma fpga, o mais próximo do hardware real que a fpga permitir.

mais detalhes abaixo.

## estado do projeto

- [x] mb8416a15sk (ram/vram) \[parcial\]
- [x] rp2a03 (cpu) \[parcial\]
- [x] sn74ls139n (decoder)
- [ ] ppu
- [ ] apu
- [ ] cartridge
- [ ] mappers
- [ ] controles
- [ ] vga
- [ ] rs-232 (talvez)

### mappers

- [ ] SxROM
- [ ] TxROM
- [ ] NROM
- [ ] UxROM
- [ ] CxROM
- [ ] AxROM
- [ ] ExROM
- [ ] PxROM
- [ ] FxROM
- [ ] GxROM
- [ ] TxSROM

| Família | Placas listadas                                                                                                                  | Mapper iNES |
| ------- | -------------------------------------------------------------------------------------------------------------------------------- | ----------- |
| NROM    | HROM, NROM-128, NROM-256, RROM, SROM                                                                                             | 0           |
| SxROM   | SAROM, SBROM, SCROM, SEROM, SFROM, SGROM, SHROM, SJROM, SKROM, SLROM, SL1ROM, SL2ROM, SL3ROM, SLRROM, SNROM, SOROM, SUROM, SXROM | 1           |
| UxROM   | UNROM, UN1ROM, UOROM                                                                                                             | 2, 94       |
| CxROM   | CNROM, CPROM                                                                                                                     | 3, 13       |
| TxROM   | TEROM, TFROM, TGROM, TKROM, TLROM, TNROM, TQROM, TR1ROM, TSROM, TVROM                                                            | 4           |
| ExROM   | EKROM, ELROM, ETROM, EWROM                                                                                                       | 5           |
| AxROM   | AMROM, ANROM, AN1ROM, AOROM                                                                                                      | 7           |
| PxROM   | PNROM, PEEOROM                                                                                                                   | 9           |
| FxROM   | FJROM, FKROM                                                                                                                     | 10          |
| TxSROM  | TKSROM, TLSROM                                                                                                                   | 118         |
| GxROM   | GNROM, MHROM                                                                                                                     | 66          |

## fpga

a fpga usada neste projeto é a [Altera DE1](https://www.terasic.com.tw/cgi-bin/page/archive.pl?No=83).
especificações podem ser encontradas [aqui](https://www.terasic.com.tw/cgi-bin/page/archive.pl?Language=English&CategoryNo=183&No=83&PartNo=2#contents).

> [!WARNING]
> todos os testes e execuções estão sendo feitos exclusivamente na fpga Cyclone II `EP2C20F484C7`, então não é garantido que funcione em outras placas.

### quartus

a última versão que o chip da fpga suporta é o quartus 13.0 sp1, e é essa versão que está sendo usada para compilar e gravar na fpga.

essa versão pode ser encontrada para download [aqui](https://www.altera.com/downloads/fpga-development-tools/quartus-ii-web-edition-design-software-version-13-0sp1-linux).

> [!IMPORTANT]
> o `.qsf` e `.qpf` são gerados a partir do [setup.tcl](./setup.tcl), portanto recomenda-se não editar o arquivo à mão, pois será sobrescrito no próximo uso do setup.tcl.

### pinos físicos utilizados

| Pinos   | Nome do fio    | Descrição                                 |
| ------- | -------------- | ----------------------------------------- |
| PIN_R20 | LED_RST        | led aceso quando rst está ativo           |
| PIN_U22 | LED_RUNNING    | led aceso quando rst está desativado      |
| PIN_U21 | LED_MASTER_CLK | led acende conforme o master clock oscila |  |
| PIN_V22 | LED_CPU_CLK    | led acende conforme o o cpu clock oscila  |
| PIN_D12 | CLK_27         | Clock 27 MHz de input                     |

## como rodar

> [!TIP]
> o uso do **distrobox** é recomendado, principalmente em uma distro mais antiga, como Ubuntu 18.04, que é a que estou usando para desenvolvimento.
>
> motivo: evitar possíveis bugs do quartus com libs mais recentes.

> [!IMPORTANT]
> é necessário que em caso de uso do distrobox, seja permitido a ele enxergar as conexões USB e permissão de escrita no USB Blaster.

```bash
./compile.sh
./flash.sh
```