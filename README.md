# 📱 Achados e Perdidos - Flutter App

## 🎓 Alunos
- **Ian Rodnir Tulio** — RA: 2578891  
- **Rogerio Jesuino** — RA: 2566214
---

## 📝 Sobre o Projeto

O sistema permite que usuários registrem itens encontrados, busquem objetos perdidos e entrem em contato de forma simples e rápida. Os dados são persistidos localmente com Hive, garantindo que itens e contas não se percam ao fechar o aplicativo.

---

## 🚀 Funcionalidades
- Cadastro e autenticação de usuários por RA e senha
 -Cadastro de itens perdidos/achados com foto e descrição
 -Edição e exclusão de itens cadastrados pelo próprio usuário
 -Contato direto com quem encontrou o item (via e-mail exibido no app)
 -Edição de perfil (nome, e-mail e senha)
 -Persistência local de dados com Hive (dados mantidos após fechar o app)

---

## 🛠️ Tecnologias Utilizadas
- **Flutter** — Framework para desenvolvimento mobile  
- **Dart** — Linguagem de programação  
- **Firebase / SQLite** — Persistência de dados (opcional)  
- **HIVE** — Banco de dados local
- **HIVE FLUTTER** — Integracao do Hive com Flutter 
---

## 📁 Estrutura do Projeto

```bash
lib/
├── models/      # Classes de dados (Item, Usuário)
├── screens/     # Telas (Home, Cadastro, Detalhes)
├── widgets/     # Componentes reutilizáveis
└── main.dart    # Ponto de entrada

## Como rodar o projeto

Pré-requisitos
Flutter instalado
Dart instalado
Emulador ou dispositivo físico
Passos
# Clone o repositório
git clone https://github.com/RogerioJesuinoFR/flutter_application_achados_perdidos.git

# Acesse a pasta do projeto
cd flutter_application_achados_perdidos

# Instale as dependências
flutter pub get

# Execute o app
flutter run





OBS: 🔐 Autenticação - login é feito por RA + senha. A senha exige:

Mínimo de 8 caracteres
Pelo menos 1 letra maiúscula
Pelo menos 1 letra minúscula
Pelo menos 1 número
Pelo menos 1 símbolo

Cada RA só pode ser cadastrado uma vez. O RA não pode ser alterado após o cadastro.