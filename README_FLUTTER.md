# PGA Mobile - Flutter

Sistema de Gestão de Projetos Acadêmicos da Fatec Votorantim convertido para Flutter.

## 🚀 **Conversão Completa**

Este projeto foi convertido de **React Native** para **Flutter** mantendo:
- ✅ **Layout idêntico** - Mesma aparência visual
- ✅ **Funcionalidades** - Todas as features implementadas
- ✅ **Navegação** - Mesma estrutura de rotas
- ✅ **Tema** - Cores e estilos da Fatec Votorantim
- ✅ **Lógica de negócio** - Validações e comportamentos

## 📱 **Funcionalidades**

- **Login** - Autenticação com validação
- **Dashboard** - Visão geral com estatísticas
- **Projetos** - Lista com filtros e busca
- **Criar Projeto** - Formulário completo
- **Configurações** - Preferências do usuário
- **Navegação** - Barra inferior funcional

## 🛠️ **Tecnologias**

- **Flutter** 3.0+
- **Dart** 3.0+
- **Go Router** - Navegação
- **Provider** - Gerenciamento de estado
- **Material Design 3** - Interface moderna

## 📋 **Pré-requisitos**

1. **Flutter SDK** instalado
2. **Android Studio** ou **VS Code**
3. **Emulador Android** ou **iOS Simulator**
4. **Git** para clonar o projeto

## 🚀 **Como Executar**

### 1. **Instalar Dependências**
```bash
flutter pub get
```

### 2. **Verificar Configuração**
```bash
flutter doctor
```

### 3. **Executar o Projeto**
```bash
flutter run
```

### 4. **Build para Produção**
```bash
# Android APK
flutter build apk

# iOS
flutter build ios
```

## 📁 **Estrutura do Projeto**

```
lib/
├── main.dart                 # Ponto de entrada
├── src/
│   ├── theme/
│   │   └── app_theme.dart   # Tema da aplicação
│   ├── screens/
│   │   ├── login_screen.dart
│   │   ├── dashboard_screen.dart
│   │   ├── projects_screen.dart
│   │   ├── create_project_screen.dart
│   │   └── settings_screen.dart
│   └── widgets/
│       ├── stats_card.dart
│       ├── project_card.dart
│       └── bottom_navigation.dart
```

## 🎨 **Tema e Cores**

- **Primária**: `#AE0F0A` (Vermelho Fatec)
- **Secundária**: `#8B0000` (Vermelho escuro)
- **Fundo**: `#F5F5F5` (Cinza claro)
- **Superfície**: `#FFFFFF` (Branco)
- **Texto**: `#1C1B1F` (Preto)

## 📱 **Telas Implementadas**

### **Login Screen**
- Imagem de fundo da Fatec
- Logo da instituição
- Formulário de login
- Validação de campos
- Overlay para legibilidade

### **Dashboard Screen**
- Cards de estatísticas
- Informações da instituição
- Projetos em destaque
- Tabs de navegação
- FAB para criar projeto

### **Projects Screen**
- Lista de projetos
- Filtros por status
- Busca por nome/responsável
- Cards de projeto detalhados

### **Create Project Screen**
- Formulário completo
- Seletor de data
- Slider de progresso
- Validações
- Feedback visual

### **Settings Screen**
- Configurações de notificação
- Preferências de aparência
- Configurações do sistema
- Gerenciamento de conta
- Informações sobre o app

## 🔧 **Configurações**

### **Android**
- `android/app/build.gradle` - Configurações de build
- `android/app/src/main/AndroidManifest.xml` - Permissões

### **iOS**
- `ios/Runner/Info.plist` - Configurações do iOS
- `ios/Runner.xcodeproj` - Projeto Xcode

## 📊 **Dados Mockados**

O projeto inclui dados de exemplo para demonstração:
- **12 projetos** com diferentes status
- **Estatísticas** realistas
- **Usuários** fictícios
- **Datas** futuras

## 🚀 **Próximos Passos**

Para produção, considere:
1. **Backend real** - API REST ou GraphQL
2. **Autenticação** - JWT, OAuth, etc.
3. **Banco de dados** - SQLite local + sincronização
4. **Notificações push** - Firebase Cloud Messaging
5. **Testes** - Unit, Widget, Integration
6. **CI/CD** - GitHub Actions, Fastlane

## 📝 **Notas da Conversão**

- **React Native** → **Flutter**: Componentes convertidos para Widgets
- **Navigation** → **Go Router**: Sistema de roteamento moderno
- **StyleSheet** → **ThemeData**: Sistema de temas nativo
- **useState** → **StatefulWidget**: Gerenciamento de estado
- **LinearGradient** → **Container + BoxDecoration**: Gradientes nativos

## 🤝 **Contribuição**

1. Fork o projeto
2. Crie uma branch para sua feature
3. Commit suas mudanças
4. Push para a branch
5. Abra um Pull Request

## 📄 **Licença**

Este projeto está sob a licença MIT. Veja o arquivo `LICENSE` para mais detalhes.

## 👨‍💻 **Desenvolvido por**

Sistema de Gestão de Projetos Acadêmicos - Fatec Votorantim
© 2025 Todos os direitos reservados
