## Checklist para Manutenção em Windows

### Análise HD

- [ ] Executar o checkdisk `checkdisk /r`
- [ ] Após concluir o checkdisk executar o `sfc /scannow`
- [ ] Reparar arquivos corrompidos ou ausentes do SO `dism /online /Cleanup-image /Restorehealth`

### Eliminação de arquivos temporários

- [ ] Executar limpeza de disco
- [ ] Instalação e execução do [CCleaner](https://www.ccleaner.com/pt-br/ccleaner/download)

### Remoção de Bloatwares

- [ ] Instalação e execução do [The PC Decrapifier](https://www.pcdecrapifier.com/)

### Remoção de PUP, Vírus e Propagandas

- [ ] Instalação e execução do [AdwCleaner](https://br.malwarebytes.com/adwcleaner/)
- [ ] Remover qualquer tipo de otimizador do Windows
- [ ] Verificação online com [Panda Cloud Cleaner](https://www.pandasecurity.com/pt/homeusers/cloud-cleaner/)
- [ ] Verificação online com [HouseCall](https://www.trendmicro.com/pt_br/forHome/products/housecall.html)
- [ ] Verificação online com [Eset Scanner](https://www.eset.com/br/antivirus-domestico/online-scanner/)
- [ ] Instalação da extensão `ublock origin` no Chrome para bloqueio de propaganda
- [ ] Instalação da extensão [Traffic Light](https://www.bitdefender.com/solutions/trafficlight.html) para bloqueio de páginas maliciosas

### Antivírus recomendados

- [] Instalação e configuração do gratuito [Panda Dome](https://www.pandasecurity.com/pt/homeusers/free-antivirus/)
- [ ] Instalação e configuração do pago [Kaspersky](https://www.kaspersky.com.br/home-security)

### Desfragmentação do HD

- [ ] Instalação e execução do [Defraggler](https://www.ccleaner.com/defraggler?cc-noredirect=)

### Windows Update

- [ ] Verificar se existe algum problema com o Windows Update e aplicar as correções/atualizações necessárias. Selecione Iniciar  > Configurações  > Atualização e Segurança   > Solucionar problemas > Solucionadores de problemas adicionais. A seguir, em Instale e execute, selecione Windows Update> Execute o solucionador de problemas.

### Visualizador de Eventos

-[ ] Ler os logs do visualizador de eventos para verificar as causas dos erros

### HDs

- [ ] Verificar, ao menos, uma vez por ano a saúde dos discos rígidos [WDD](https://support.wdc.com/downloads.aspx?lang=en&p=279)
- [ ] Recuperar espaço livre no disco usando [Treesize Free](https://www.jam-software.com/treesize_free)
- [ ] Remover drivers antigos da pasta [Driver Store](https://github.com/lostindark/DriverStoreExplorer)
- [ ] Compactar os arquivos do Windows com: `>compact.exe /CompactOS:query` e `>compact.exe /CompactOS:Always`
- [ ] Não recomendando, mas se quiser apagar dados da pasta `WinSxS` execute esse comando. Essa pasta é um repositório de componentes para restauração do Windows.`Dism.exe /online /cleanup-Image /StartComponentCleanup /ResetBase`
- [ ] Apagar os arquivos de instalação dos programas localizados em `c:\Windows\Installer`. Para isso é necessário usar o [PatchCleaner](https://www.homedev.com.au/Free/PatchCleaner)

### Backups

- [ ] Configurar o backup do Windows e certificar que está funcionando sua restauração