O kubernetes, também conhecido como k8s, é uma plataforma open-source para implantação
dimensionamento, escalonamento e gerenciamento de container. O kubernetes trabalha com qualquer container runtime como: `containerd`, `lxc`, `podman`, `cri-o`, `frakti`.
O kubernetes vai trabalhar como orquestrador.

O Pod é a menor e mais básica estrutura do Kubernetes. O Pod consiste de um ou mais containers, recursos de armazenamento e um único endereço IP. É no pod que os containers são executados.
Os pods são efêmeros. Eles não são projetados para permanecer em execução para sempre e, depois de encerrados, não pode ser recuperados. Seu cilo de vida é:
`PENDING -> RUNNING -> SUCEEDED -> UNKNOW -> FAILED`

- PENDING: o pod foi criado e aceito pelo cluster, mas um ou mais containers ainda não estão em execução. Essa fase inclui o tempo de escalonamento e o tempo de download da imagem.
- RUNNING: o pod foi alocado a um nó e todos os containers foram criados. Pelo menos um container está em execução, no processo de iniciar ou está reiniciando.

- SUCEEDED: todos os containers no pod foram encerrados com sucesso. Os pods encerrados não são reiniciados.

- FAILED: todos os containers no pod foram encerrados e pelo menos um foi encerrado com falha.

- UNKNOW: o pod não pode ter seu estado conhecido.

O kubernetes pode ser instalado tanto em máquinas físicas quanto em máquinas virtuais de duas formas: `Single Node` ou `Cluster`

- Single Node: apenas um único nó executa toda a aplicação;
- Cluster: dois um nós executam a aplicação.

O modo padrão de instalação do kubernetes é em modo `cluster`
No modo `cluster` temos que o cluster é formado por dois tipos de nós.

- `Workder`: são os nós que executam os containers

- `Master`: executa os componentes do plano de controle

Em todos os nós do kubernetes temos os seguintes componentes comuns:

- kubeadm: é a ferramenta que automatiza grande parte do processo de criação do cluster.
- kubelet: lida com a execução de pods, atua como um agente em cada node intermediando as trocas de mensagens entre API Server e o Docker runtime
- kubectl: ferramenta CLI, permite executar comando no cluster, implantar aplicativos, inspecionar e gerenciar recursos e visualizar logs
- docker

No nó master além dos componentes comuns temos também o:

- control plane

O control plane possui os seguintes componentes:

- etcd: provê um sistema distribuído e compartilhado para armazenar informações sobre o estado do cluster
- API Server: provê todos os serviços do kubernetes. É um serviço REST. Valida e configura dados para os objetos de API que incluem pods, serviços, controladores de replicação e outros.
- control manager: executa funções em nível de cluster, como replicar componentes, acompanhar nós de trabalho, lidar com falhas em nós, etc.
- scheduler: escalona os pods para serem executados nos nodes.

Ambiente de estudo, softwares necessários:

- docker: [](https://docs.docker.com/engine/install/debian/)
- minikube: [](https://k8s-docs.netlify.app/en/docs/tasks/tools/install-minikube/)
- kubectl: [](https://k8s-docs.netlify.app/en/docs/tasks/tools/install-kubectl/)

Outras ferramentas que podem ser usadas para estudar o kubernetes são `kind`, `k3s`, `kubeadm`

O `minikube` é um utilitário que você pode executar o kubernetes em sua máquina local. Ele cria um cluster de nó único contido em uma máquina virtual. Ele é leve e fácil de usar, oferece suporte a diversas plataformas, tem um leque bem robusto de features a serem utilizadas e muita documentação escrita. Sua desvantagem é que não é possível trabalhar com múltiplos nós e o tempo de inicialização é lento.

Para inicializar o minikube depois de instalado:

`$ minikube start`

O kubernetes possui dois modos de interação:

- `Imperativa`: usando o `kubectl` e os seus diversos parâmetros

- `Declarativa`: usa arquivos de manifesto no formato YAML (ou JSON) e aplica
  uando o comando `kubectl apply`

Nos arquivos de manifesto nos vamos ter as definições de `deployments`,
`services`, `pods`, `namespaces`, `replicasets`, `configmaps`, `secrets`,
`nodes` e outros objetos que desejamos definir.
